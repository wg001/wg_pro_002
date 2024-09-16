import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

class DepositPay extends StatefulWidget {
  const DepositPay({super.key});

  @override
  _DepositPayState createState() => _DepositPayState();
}

class _DepositPayState extends State<DepositPay> {
  final bool _isLoading = false; // 初始加载指示器
  final ScrollController _scrollController = ScrollController(); // 滚动控制器

  @override
  void dispose() {
    _scrollController.dispose(); // 释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置回退图标的颜色
        ),
        title: const Text(
          '存款',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.red, // AppBar 背景设为红色
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // 显示加载指示器
          : Stack(
              children: [
                // 列表部分
                Positioned.fill(
                  top: 0,
                  child: SingleChildScrollView(
                    child: _buildContent(context),
                  ),
                ),
                // 顶部部分
                // ,
              ],
            ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      height: 140, // 设置明确的高度
      padding: const EdgeInsets.all(20),
      color: WGColors.ThemeColor, // 红色背景
      child: const Center(
        child: Text(
          '存款信息',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    TextStyle amountTextStyle = const TextStyle(
      color: Color.fromRGBO(153, 153, 153, 1),
    );

    return Container(
        height: MathUtils.screenHeight - 140,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 左对齐
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("应付金额"),
                  SizedBox(width: 10),
                ],
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "P6,000,000",
                  style: TextStyle(
                    color: Color.fromRGBO(201, 33, 42, 1),
                    fontSize: 20,
                  ),
                )
              ]),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 244, 222, 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "存款金额：Rp100.000.000",
                      style: amountTextStyle,
                    ),
                    Text(
                      "会费 Rp100.000.000",
                      style: amountTextStyle,
                    ),
                    Text(
                      "月费 Rp100.000.000",
                      style: amountTextStyle,
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "付款渠道",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontSize: 13,
                  ),
                )
              ]),
              const SizedBox(height: 5),
              const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "XX银行",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontSize: 18,
                  ),
                )
              ]),
              const Gap(40),
              Row(
                children: [
                  const Text(
                    "支付代码",
                    style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontSize: 13,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cached_rounded),
                    color: const Color.fromARGB(255, 106, 255, 143),
                    iconSize: 30.0,
                    tooltip: '刷新',
                    onPressed: () {
                      // 点击按钮时执行的操作
                      CommonUtils.showToast("已刷新数据");
                    },
                  ),
                ],
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "107 341102 0843 1155",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontSize: 18,
                  ),
                )
              ]),
              const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "*有效期至: 12/31/2021 10:10:1",
                  style: TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1),
                    fontSize: 12,
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
