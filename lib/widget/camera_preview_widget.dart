import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/provider/camera_provider.dart'; // 确保路径正确

class CameraPreviewWidget extends StatefulWidget {
  final Function(String) onImageCaptured;
  final Widget? overlayWidget; // 新增一个参数用于接收遮罩层
  final List<DeviceOrientation>? preferredOrientations;
  final CameraLensDirection? initialCameraDirection; //前置，后置摄像头的控制

  const CameraPreviewWidget(
      {super.key,
      required this.onImageCaptured,
      this.overlayWidget,
      this.preferredOrientations,
      this.initialCameraDirection});

  @override
  _CameraPreviewWidgetState createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  double _scale = 1.0;
  double _baseScale = 1.0;
  final double _minZoom = 1.0;
  double _maxZoom = 3.0; // 假定最大缩放，你也可以动态获取

  @override
  void initState() {
    super.initState();

    if (widget.initialCameraDirection != null) {
      Provider.of<CameraProvider>(context, listen: false)
          .initCamera(widget.initialCameraDirection!);
    }
    SystemChrome.setPreferredOrientations(widget.preferredOrientations ??
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
    initializeZoomLevel();
  }

  Future<void> initializeZoomLevel() async {
    final cameraManager = Provider.of<CameraProvider>(context, listen: false);
    if (cameraManager.isInitialized) {
      double maxZoom = await cameraManager.cameraController!.getMaxZoomLevel();
      setState(() {
        _maxZoom = maxZoom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (context, cameraManager, child) {
        if (!cameraManager.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        return GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            _baseScale = _scale;
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            double newScale = _baseScale * details.scale;
            if (newScale != _scale &&
                newScale >= _minZoom &&
                newScale <= _maxZoom) {
              cameraManager.setZoom(newScale);
              setState(() {
                _scale = newScale;
              });
            }
          },
          child: Stack(
            children: [
              // CameraPreview(cameraManager.cameraController!),
              Positioned.fill(
                child: CameraPreview(
                    cameraManager.cameraController!), // 确保摄像头预览填充整个屏幕
              ),
              if (widget.overlayWidget != null) widget.overlayWidget!,
              widget.overlayWidget ?? const SizedBox(), // 使用传入的遮罩层或默认为空的Widget
              _buildCameraControls(context, cameraManager),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCameraControls(
      BuildContext context, CameraProvider cameraManager) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FloatingActionButton(
                onPressed: () async {
                  XFile photo =
                      await cameraManager.cameraController!.takePicture();
                  widget.onImageCaptured(photo.path);
                },
                backgroundColor: Colors.transparent,
                child: Image.asset(
                    '${Config.BASE_APP_ASSETS_PATH}take_picture.png'),
              ),
              IconButton(
                //camera_flip
                icon: Image.asset(
                    '${Config.BASE_APP_ASSETS_PATH}camera_flip.png'),
                onPressed: () => cameraManager.toggleCamera(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
