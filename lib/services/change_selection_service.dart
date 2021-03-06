import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data_base/data/local_data_base.dart';
import '../data_base/data_base.dart';
import '../models/selection.dart';
import '../models/selections.dart';
import '../models/tales_list.dart';
import '../utils/texts_consts.dart';

class ChangeSelectionService {
  ChangeSelectionService();
  String name = TextsConst.addNewSelectionsTextName;
  String? description;
  String? photo;
  String? photoUrl;
  List<String> checkedList = [];
  bool readOnly = true;

  void checkEvent(bool isChecked, String id) {
    if (isChecked) {
      checkedList.remove(id);
    } else {
      checkedList.add(id);
    }
  }

  Future<void> saveCreatedSelectionEvent(
      {required TalesList talesList,
      required SelectionsList selectionsList}) async {
    String _selectionId = DateTime.now().millisecondsSinceEpoch.toString();
    String _date = DateTime.now().millisecondsSinceEpoch.toString();

    TalesList _talesList = talesList;
    SelectionsList _selectionsList = selectionsList;

    for (String id in checkedList) {
      _talesList.fullTalesList.map(
        (element) {
          if (element.id == id) {
            element.selectionsId.add(_selectionId);
          }
          return element;
        },
      ).toList();
    }

    if (photo != null) {
      File imageFile = File(photo!);
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('${LocalDB.instance.getUser().id}/images/selections_photo')
            .child(_selectionId);
        await storageRef.putFile(imageFile);
        photoUrl = await storageRef.getDownloadURL();
      } catch (e) {
        BotToast.showText(text: e.toString());
      }
    }

    Selection selection = Selection(
      id: _selectionId,
      name: name,
      date: _date,
      description: description,
      photo: photo,
      photoUrl: photoUrl,
    );

    _selectionsList.addNewSelection(selection);

    DataBase.instance.saveAudioTales(_talesList);
    DataBase.instance.saveSelectionsList(_selectionsList);
    dispouse();
  }

  Future<void> saveChangedSelectionEvent({
    required SelectionsList selectionsList,
    required Selection selection,
  }) async {
    SelectionsList _selectionsList = selectionsList;
    Selection _selection = selection;

    if (photo != null) {
      File imageFile = File(photo!);
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('${LocalDB.instance.getUser().id}/images/selections_photo')
            .child(_selection.id);
        await storageRef.putFile(imageFile);
        photoUrl = await storageRef.getDownloadURL();
      } catch (e) {
        BotToast.showText(text: e.toString());
      }
    }

    _selection.name = name;
    _selection.description = description;
    _selection.photo = photo;
    _selection.photoUrl = photoUrl;

    _selectionsList.replaceSelection(selection: _selection);

    DataBase.instance.saveSelectionsList(_selectionsList);
    dispouse();
  }

  void dispouse() {
    name = TextsConst.addNewSelectionsTextName;
    description = null;
    photo = null;
    photoUrl = null;
    checkedList = [];
    readOnly = true;
  }
}
