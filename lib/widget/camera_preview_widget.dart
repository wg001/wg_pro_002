import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/provider/camera_provider.dart'; // 确保路径正确

class CameraPreviewWidget extends StatefulWidget {
  final Function(String) onImageCaptured;

  const CameraPreviewWidget({super.key, required this.onImageCaptured});

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
              CameraPreview(cameraManager.cameraController!),
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                onPressed: () => cameraManager.toggleCamera(),
              ),
              FloatingActionButton(
                onPressed: () async {
                  XFile photo =
                      await cameraManager.cameraController!.takePicture();
                  widget.onImageCaptured(photo.path);
                },
                backgroundColor: Colors.red,
                child: const Icon(Icons.camera),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Slider(
            value: _scale,
            min: _minZoom,
            max: _maxZoom,
            onChanged: (value) {
              setState(() {
                _scale = value;
              });
              cameraManager.setZoom(_scale);
            },
            activeColor: Colors.white,
            inactiveColor: Colors.white30,
          ),
        ),
      ],
    );
  }
}
