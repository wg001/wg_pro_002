import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isInitialized = false;
  double currentZoomLevel = 1.0; // 默认缩放级别

  Future<void> initCamera(CameraLensDirection lensDirection) async {
    cameras = await availableCameras();
    CameraDescription selectedCamera = cameras!.firstWhere(
      (camera) => camera.lensDirection == lensDirection,
      orElse: () => cameras!.first,
    );

    cameraController = CameraController(
      selectedCamera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await cameraController!.initialize();
    isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleCamera() async {
    if (!isInitialized) return;
    CameraLensDirection newDirection =
        cameraController!.description.lensDirection == CameraLensDirection.back
            ? CameraLensDirection.front
            : CameraLensDirection.back;

    await initCamera(newDirection);
  }

  Future<void> setZoom(double zoom) async {
    if (cameraController != null) {
      currentZoomLevel = zoom;
      await cameraController!.setZoomLevel(zoom);
      notifyListeners();
    }
  }

  Future<void> disposeCamera() async {
    await cameraController?.dispose();
    isInitialized = false;
    notifyListeners();
  }
}
