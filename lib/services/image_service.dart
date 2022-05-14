import 'dart:io';

import 'package:audiotales/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../data_base/data/local_data_base.dart';
import '../data_base/data_base.dart';

class ImageServise {
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  Future pickImage(LocalUser localUser) async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageFile = File(image.path);
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${LocalDB.instance.getUser().id}/images/avatar')
          .child('${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile!);
      localUser.photoUrl = await storageRef.getDownloadURL();
    } catch (e) {
      localUser.photo = image.path;
      print(e);
    }
    // localUser.photo = image.path;
    DataBase.instance.saveUser(Future.value(localUser));
  }
}
