import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../../../models/tale.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../services/minuts_text_convert_service.dart';
import '../../../../../utils/custom_colors.dart';
import '../../../../../utils/custom_icons.dart';
import '../../../../../utils/texts_consts.dart';
import '../../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../bloc/selections_bloc.dart';
import 'select_audio_text.dart';

class SelectAudioScreen extends StatelessWidget {
  const SelectAudioScreen({Key? key}) : super(key: key);
  static const routeName = '/select_audio_screen.dart';

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: _appBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: _screen.height / 7,
                  color: CustomColors.oliveSoso,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: _AudiolistSelectAudioWidget(),
              ),
            ],
          ),
          const Align(
            alignment: Alignment(0, -0.9),
            child: _SelectAudioSearchWidget(),
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  Size screen = MediaQuery.of(context).size;
  const SelectAudioText title = SelectAudioText();
  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const SelectAudioTextAdd(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ],
    backgroundColor: CustomColors.oliveSoso,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      padding: const EdgeInsets.only(left: 16),
      icon: SvgPicture.asset(
        CustomIconsImg.arrowLeftCircle,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: title,
  );
}

class _AudiolistSelectAudioWidget extends StatelessWidget {
  const _AudiolistSelectAudioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final List<AudioTale> _tales = context
            .read<TalesListRepository>()
            .getTalesListRepository()
            .getActiveTalesList();
        List<AudioTale> _talesList = _tales;
        if (state.searchValue != null) {
          _talesList = _tales
              .where((element) => element.name
                  .toLowerCase()
                  .contains(state.searchValue?.toLowerCase() ?? ''))
              .toList();
        }

        return SizedBox(
          height: _screen.height * 0.7,
          child: ListView.builder(
            itemCount: _talesList.length,
            itemBuilder: (_, i) {
              return _ListItem(
                talesList: _talesList,
                i: i,
              );
            },
          ),
        );
      },
    );
  }
}

class _ListItem extends StatefulWidget {
  const _ListItem({
    Key? key,
    required this.talesList,
    required this.i,
  }) : super(key: key);
  final List<AudioTale> talesList;
  final int i;

  @override
  State<_ListItem> createState() => __ListItemState();
}

class __ListItemState extends State<_ListItem> {
  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    final bool isChecked = _selectionsBloc.changeSelectionService.checkedList
        .contains(widget.talesList.elementAt(widget.i).id);
    return Padding(
      padding: EdgeInsets.all(_screen.height * 0.005),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    CustomIconsImg.playSVG,
                    color: CustomColors.oliveSoso,
                  ),
                  iconSize: _screen.height * 0.05,
                ),
                SizedBox(
                  width: _screen.width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.talesList.elementAt(widget.i).name),
                    _AudioListText(audio: widget.talesList.elementAt(widget.i)),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                _selectionsBloc.add(CheckEvent(
                    isChecked: isChecked,
                    id: widget.talesList.elementAt(widget.i).id));
                setState(() {});
              },
              icon: isChecked
                  ? SvgPicture.asset(
                      CustomIconsImg.check,
                      height: _screen.height * 0.055,
                      color: CustomColors.black,
                    )
                  : SvgPicture.asset(
                      CustomIconsImg.uncheck,
                      height: _screen.height * 0.055,
                      color: CustomColors.black,
                    ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: CustomColors.white,
          border: Border.all(color: CustomColors.audioBorder),
          borderRadius: const BorderRadius.all(Radius.circular(41)),
        ),
      ),
    );
  }
}

class _AudioListText extends StatelessWidget {
  const _AudioListText({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final AudioTale audio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      buildWhen: (previous, current) {
        return previous.readOnly != current.readOnly;
      },
      builder: (context, state) {
        String text = TimeTextConvertService.instance
            .getConvertedMinutesText(timeInMinutes: audio.time);

        return audio.id != state.chahgedAudioId
            ? Text(
                '${audio.time.round()} $text',
                style: const TextStyle(
                  color: CustomColors.noTalesText,
                  fontFamily: 'TT Norms',
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class _SelectAudioSearchWidget extends StatelessWidget {
  const _SelectAudioSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    return Container(
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(41),
        ),
        width: 309,
        height: 59,
        child: TextFormField(
          autofocus: false,
          onChanged: (value) {
            _selectionsBloc.add(SearchAudioToAddInSelectionEvent(value: value));
          },
          textAlign: TextAlign.start,
          cursorRadius: const Radius.circular(41.0),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: TextsConst.search,
            hintStyle: const TextStyle(color: CustomColors.noTalesText),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                CustomIconsImg.search,
                color: CustomColors.black,
              ),
            ),
            suffixIconColor: CustomColors.black,
          ),
        ));
  }
}
