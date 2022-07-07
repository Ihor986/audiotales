import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../models/audio.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons.dart';
import '../../../../../utils/consts/texts_consts.dart';
import '../../../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../bloc/selections_bloc.dart';
import 'select_audio_text.dart';

class SelectAudioScreen extends StatelessWidget {
  const SelectAudioScreen({Key? key}) : super(key: key);
  static const routeName = '/select_audio_screen.dart';

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

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
                  height: screen.height / 7,
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
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getActiveTalesList();
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final Size screen = MediaQuery.of(context).size;
        final SelectionsBloc _selectionsBloc =
            BlocProvider.of<SelectionsBloc>(context);
        List<AudioTale> _talesList = talesList;
        if (state.searchValue != null) {
          _talesList = talesList
              .where(
                  (element) => element.name.contains(state.searchValue ?? ''))
              .toList();
        }
        List<String> checkedList =
            _selectionsBloc.changeSelectionService.checkedList;
        return SizedBox(
          height: screen.height * 0.7,
          child: ListView.builder(
            itemCount: _talesList.length,
            itemBuilder: (_, i) {
              bool isChecked = checkedList.contains(_talesList[i].id);
              return Padding(
                padding: EdgeInsets.all(screen.height * 0.005),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // print('11111111111111');
                              // _mainScreenBloc.add(ClickPlayEvent(talesList[i]));
                            },
                            icon: SvgPicture.asset(
                              CustomIconsImg.playSVG,
                              color: CustomColors.oliveSoso,
                            ),
                            iconSize: screen.height * 0.05,
                          ),
                          SizedBox(
                            width: screen.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_talesList[i].name),
                              AudioListText(audio: _talesList.elementAt(i)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          _selectionsBloc.add(CheckEvent(
                              isChecked: isChecked, id: _talesList[i].id));
                        },
                        icon: isChecked
                            ? SvgPicture.asset(
                                CustomIconsImg.check,
                                height: screen.height * 0.055,
                                color: CustomColors.black,
                              )
                            : SvgPicture.asset(
                                CustomIconsImg.uncheck,
                                height: screen.height * 0.055,
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
            },
          ),
        );
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
                // size: 1,
                color: CustomColors.black,
              ),
            ),
            suffixIconColor: CustomColors.black,
            // suffixStyle:
          ),
        ));
  }
}
