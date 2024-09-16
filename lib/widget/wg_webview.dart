import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WgWebview extends StatefulWidget {
  final String targetUrl;
  final String barTitle;
  final List<String>? jsChannels;

  const WgWebview({
    super.key,
    required this.targetUrl,
    required this.barTitle,
    this.jsChannels,
  });

  @override
  _WgWebviewiewState createState() => _WgWebviewiewState();
}

class _WgWebviewiewState extends State<WgWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            // 页面加载完成后的操作
          },
          onWebResourceError: (error) {
            // 处理错误
          },
        ),
      );

    // 动态添加 JavaScript 通道
    if (widget.jsChannels != null) {
      for (var channel in widget.jsChannels!) {
        _controller.addJavaScriptChannel(channel,
            onMessageReceived: (JavaScriptMessage) {});
      }
    }

    // 加载目标 URL
    if (_isExternalUrl(widget.targetUrl)) {
      _controller.loadRequest(Uri.parse(widget.targetUrl));
    } else {
      _controller.loadFlutterAsset(widget.targetUrl);
    }
  }

  bool _isExternalUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.barTitle,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置回退图标的颜色
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
