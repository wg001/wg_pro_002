import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wg_pro_002/pages/user_info/user_web_view.dart';
import 'package:wg_pro_002/utils/common_utils.dart'; // Make sure to add this package to your pubspec.yaml

class UserInfoSign extends StatelessWidget {
  static const String sName = "userInfoSign";

  const UserInfoSign({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawing App")),
      body: const DrawingBoard(),
    );
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<DrawingPoints?> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 5.0;
  GlobalKey repaintBoundaryKey = GlobalKey();

  void selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void changeStrokeWidth() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change stroke width'),
          content: Slider(
            value: strokeWidth,
            min: 1.0,
            max: 10.0,
            divisions: 10,
            label: strokeWidth.round().toString(),
            onChanged: (double value) {
              setState(() {
                strokeWidth = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                points.add(
                  DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = StrokeCap.round
                      ..isAntiAlias = true
                      ..color = selectedColor
                      ..strokeWidth = strokeWidth,
                  ),
                );
              });
            },
            onPanEnd: (details) {
              points.add(null);
            },
            child: RepaintBoundary(
              key: repaintBoundaryKey,
              child: CustomPaint(
                size: Size.infinite,
                painter: DrawingPainter(points: points),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => saveToImage(context),
          child: const Text('Save Drawing'),
        ),
        const SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     IconButton(
        //       icon: const Icon(Icons.color_lens),
        //       onPressed: selectColor,
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.brush),
        //       onPressed: changeStrokeWidth,
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.clear),
        //       onPressed: () {
        //         setState(() {
        //           points.clear();
        //         });
        //       },
        //     ),
        //   ],
        // )
      ],
    );
  }

  Future<void> saveToImage(BuildContext context) async {
    if (points.isEmpty || points.every((p) => p == null)) {
      CommonUtils.showToast("plz sign your name");
      return;
    }

    try {
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final appDir = await getApplicationDocumentsDirectory();
      final filePath =
          '${appDir.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);
      print(filePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Drawing saved to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save drawing: $e')),
      );
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const WebViewScreen()));
  }
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({required this.points, required this.paint});
}

class DrawingPainter extends CustomPainter {
  List<DrawingPoints?> points;
  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
            points[i]!.points, points[i + 1]!.points, points[i]!.paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(
            ui.PointMode.points, [points[i]!.points], points[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
