import 'package:image_picker/image_picker.dart';

class ImageServise {
  ImagePicker imagePicker = ImagePicker();
  // File? imageFile;
  // Future pickImage(LocalUser localUser) async {
  //   final XFile? image = await imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 400,
  //     // imageQuality: 1,
  //   );
  //   if (image == null) return;
  //   imageFile = File(image.path);
  //   try {
  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('${LocalDB.instance.getUser().id}/images/avatar')
  //         .child('${DateTime.now().millisecondsSinceEpoch}');
  //     await storageRef.putFile(imageFile!);
  //     localUser.photoUrl = await storageRef.getDownloadURL();
  //   } catch (e) {
  //     localUser.photo = image.path;
  //     print(e);
  //   }
  //   // localUser.photo = image.path;
  //   DataBase.instance.saveUser(localUser);
  // }

  Future<String?> pickImageToCasheMemory() async {
    final XFile? image = await imagePicker.pickImage(
      maxWidth: 400,
      source: ImageSource.gallery,
      // imageQuality: 1,
    );
    return image?.path;
  }
}
