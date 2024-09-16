import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/widget/wg_webview.dart';

class DepositSubmit extends StatefulWidget {
  const DepositSubmit({super.key});

  @override
  _DepositSubmitState createState() => _DepositSubmitState();
}

class _DepositSubmitState extends State<DepositSubmit> {
  bool _privacyRead = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          '确认申请',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _mainContent(),
    );
  }

  Widget _mainContent() {
    return Container(
        decoration:
            const BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(25.0), // 所有方向上设置10像素的内边距
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      buildDetailItem(
                          "姓名",
                          "张三",
                          const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(102, 102, 102, 1))),
                      buildDetailItem(
                          "身份证号",
                          "330898******2234989",
                          const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(102, 102, 102, 1))),
                      buildDetailItem(
                          "存款金额",
                          "600,000",
                          const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(211, 182, 91, 1))),
                      buildDetailItem(
                          "存款期限",
                          "91天",
                          const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(102, 102, 102, 1))),
                    ],
                  )),
              const SizedBox(height: 30),
              _submitButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [privacyAgreementPadding()],
              )
            ],
          ),
        ));
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50, // 设置按钮和 Stack 的高度
      child: Stack(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // 确保按钮高度为 50
                backgroundColor: WGColors.ThemeColor),
            onPressed: () {
              if (_privacyRead) {
                CommonUtils.showToast("submitting...");
              }
            },
            child: const Text(
              '提交申请',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          if (!_privacyRead)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
        ],
      ),
    );
  }

  Widget privacyAgreementPadding() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
              value: _privacyRead,
              onChanged: (bool? value) {
                setState(() {
                  _privacyRead = !_privacyRead;
                });
              },
              shape: const CircleBorder(),
              fillColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.orange; // 选中时的颜色
                  }
                  return const Color.fromRGBO(245, 245, 245, 1); // 未选中时的颜色
                },
              ),
              side: const BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromARGB(255, 236, 236, 235))),
          Flexible(
            // 使用 Flexible
            fit: FlexFit.loose, // 设置为 loose 允许内部内容小于剩余空间
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '我已阅读并同意',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: '《借款协议》',
                    style: const TextStyle(
                      color: Color.fromRGBO(225, 142, 85, 1),
                      decoration: TextDecoration.none,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WgWebview(
                            targetUrl: 'https://www.google.com',
                            barTitle: '借款协议',
                          ),
                        ));
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailItem(String label, String value, TextStyle textStyle,
      {TextStyle tsStyle = const TextStyle(fontSize: 15)}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label,
              style: const TextStyle(
                fontSize: 15,
              )),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
