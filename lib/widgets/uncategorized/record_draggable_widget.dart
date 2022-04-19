import 'package:flutter/material.dart';

class RecordDraggableWidget extends StatefulWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  State<RecordDraggableWidget> createState() => _RecordDraggableWidgetState();
}

class _RecordDraggableWidgetState extends State<RecordDraggableWidget> {
  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    num screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DraggableScrollableSheet(
            initialChildSize: 0.93,
            maxChildSize: 0.93,
            minChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            spreadRadius: 3,
                            blurRadius: 10)
                      ],
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Align(
                      alignment: const Alignment(0, 0.7),
                      child: Container(
                        width: screenWidth * 1,
                        foregroundDecoration: const BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage("assets/icons/pause-2.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            print('pres pause');
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: Color.fromARGB(255, 252, 252, 0),
                          ),
                        ),
                        height: screenHeight * 0.13,
                      )));
            }),
      ),
    );
  }
}
