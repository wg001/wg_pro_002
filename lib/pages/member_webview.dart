import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_pro_002/pages/home_page.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/provider/navigation_provider.dart';

class MemberWebview extends StatefulWidget {
  final String targetUrl; // Use final and remove underscore if public

  const MemberWebview({super.key, required this.targetUrl});

  @override
  _MemberWebviewState createState() => _MemberWebviewState();
}

class _MemberWebviewState extends State<MemberWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    // const creationParams = PlatformWebViewControllerCreationParams();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Flutter', onMessageReceived: (message) {
        print("====${message.message}");
        if (message.message == 'app://goback') {
          print("dododo");
          // Navigator.pop(context);
          Provider.of<NavigationProvider>(context, listen: false)
              .setCurrentIndex(0, refreshScreen: false);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainPage()));
        }
      })
      ..loadFlutterAsset('static/html/demo.html');
    super.initState();
    // _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    // // If you need to interact with the WebView immediately after it's created:
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   // await _controller.loadRequest(Uri.parse('https://flutter.dev'));
    //   await _controller.loadFlutterAsset('static/html/demo.html');
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await _controller.loadFlutterAsset('static/html/demo.html');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView Example"),
      ),
      // body: WebViewWidget(controller: _controller),
      body: WebViewWidget(controller: _controller),
    );
  }
}
