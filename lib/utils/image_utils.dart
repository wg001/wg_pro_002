import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  static Future<Map<String, dynamic>> pickImageWeb() async {
    final ImagePicker picker = ImagePicker();
    Uint8List? imageData;
    String? extension;

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality:
            50, // Optionally reduce the image quality to reduce file size
      );
      if (pickedFile != null) {
        imageData = await pickedFile.readAsBytes();
        extension = ImageUtils.getExtensionFromPath(pickedFile.name);
      }
    } catch (e) {
      // 处理异常
      if (e is PlatformException) {
        return {'error': 'Permission denied'};
      } else {
        // 其他类型的错误处理
        print('Error: ${e.toString()}');
        return {'error': e.toString()};
      }
    }
    return {'imageData': imageData, 'extension': extension};
  }

  static String getExtensionFromPath(String filePath) {
    final parts = filePath.split('.');
    return parts.last;
  }
}
