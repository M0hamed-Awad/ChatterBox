import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    final XFile? file =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    return file != null ? File(file.path) : null;
  }
}
