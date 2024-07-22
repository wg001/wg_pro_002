import 'dart:convert';
import 'dart:typed_data';
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

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }
    return null;
  }
}
