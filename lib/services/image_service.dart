import 'package:image_picker/image_picker.dart';

class ImageServise {
  ImagePicker imagePicker = ImagePicker();

  Future<String?> pickImageToCasheMemory() async {
    final XFile? image = await imagePicker.pickImage(
      maxWidth: 400,
      source: ImageSource.gallery,
    );
    return image?.path;
  }
}
