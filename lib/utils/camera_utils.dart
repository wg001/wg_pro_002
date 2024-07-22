import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraUtils {
  static final CameraUtils _instance = CameraUtils._internal();
  CameraController? controller;

  CameraUtils._internal();

  factory CameraUtils() => _instance;

  // Modified to not automatically initialize
  Future<void> initCamera(bool useFrontCamera) async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (cam) =>
          cam.lensDirection ==
          (useFrontCamera
              ? CameraLensDirection.front
              : CameraLensDirection.back),
      orElse: () => cameras.first,
    );

    controller = CameraController(camera, ResolutionPreset.medium);
    return controller!.initialize();
  }

  Future<String?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return null;
    }

    final path =
        (await getTemporaryDirectory()).path + '/${DateTime.now()}.png';
    await controller!.takePicture().then((XFile file) => file.saveTo(path));
    return path;
  }

  void dispose() {
    controller?.dispose();
  }
}
