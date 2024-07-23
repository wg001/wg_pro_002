import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  String imageToBase64(Uint8List imageData) {
    return base64Encode(imageData);
  }

  Future<Uint8List?> compressImage(Uint8List imageData) async {
    final compressedImageData = await FlutterImageCompress.compressWithList(
      imageData,
      minWidth: 1920,
      minHeight: 1080,
      quality: 80, // 调整压缩质量
    );
    return compressedImageData;
  }

  static Future<String?> pickImageWeb() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality:
          50, // Optionally reduce the image quality to reduce file size
    );
    return pickedFile?.path;
  }

  static String getExtensionFromPath(String filePath) {
    final parts = filePath.split('.');
    return parts.last;
  }
}
