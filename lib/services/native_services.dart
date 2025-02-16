import 'dart:io';

import 'package:image_picker/image_picker.dart';

class NativeServices {
  final ImagePicker picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    final image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
