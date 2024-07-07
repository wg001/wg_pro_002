import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; // 仅Web环境下使用
import 'package:image_picker/image_picker.dart'; // 移动端使用

class PlatformImagePicker {
  Future<Uint8List?> pickImage() async {
    if (kIsWeb) {
      // Web平台使用dart:html
      return pickImageWeb();
    } else {
      // 移动端使用image_picker
      return pickImageMobile();
    }
  }

  Future<Uint8List?> pickImageWeb() async {
    var uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    await uploadInput.onChange.first;
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoadEnd.first;
      return reader.result as Uint8List?;
    }
    return null;
  }

  Future<Uint8List?> pickImageMobile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return await image.readAsBytes();
    }
    return null;
  }
}
