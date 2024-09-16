import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/pages/deposit/deposit_apply.dart';
import 'package:wg_pro_002/pages/user_loan/loan_apply.dart';

class LoanOption extends StatefulWidget {
  const LoanOption({super.key});

  @override
  _LoanOptionState createState() => _LoanOptionState();
}

class _LoanOptionState extends State<LoanOption> {
  final bool _isLoading = false; // 初始加载指示器
  final formatter = NumberFormat("#,##0");
  final double _lowestAmount = 100000;
  final double _highestAmount = 10000000;
  late double _currentAmount = _lowestAmount;
  int _selectedTerm = 1;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕高度
    final screenHeight = MediaQuery.of(context).size.height;
    // 顶部部分的高度
    const double topSectionHeight = 150.0;
    // 下方内容与顶部部分的重叠高度
    const double overlapHeight = 30.0;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置返回图标的颜色
        ),
        title: const Text('存款服务'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // 显示加载指示器
          : Stack(
              children: [
                // 将 _buildTopSection 放在最下面
                _buildTopSection(context),
                // 下方内容部分，使用 Positioned 来定位
                Positioned(
                  top: 100, // 控制重叠程度
                  left: 0,
                  right: 0,
                  bottom: 0, // 确保下方内容占满剩余空间
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    // 由于指定了 bottom: 0，这里不需要再指定高度
                    decoration: const BoxDecoration(
                      color: Colors.white, // 设置下方内容的背景颜色
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), // 为顶部添加圆角
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // 使用 Expanded 包裹 SingleChildScrollView
                        Expanded(
                          child: SingleChildScrollView(
                            child: _mainContent(),
                          ),
                        ),
                        // 底部按钮
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _mainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // 使Column高度自适应子组件
        children: <Widget>[
          const Text(
            '借款金额',
            style: TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            formatter.format(_currentAmount),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color.fromRGBO(200, 29, 40, 1),
              inactiveTrackColor: const Color.fromRGBO(241, 241, 241, 1),
              trackHeight: 8.0,
              thumbColor: const Color.fromRGBO(200, 29, 40, 1),
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 10,
              ),
              overlayColor: const Color.fromRGBO(200, 29, 40, 1),
              tickMarkShape: SliderTickMarkShape.noTickMark,
            ),
            child: Slider(
              min: _lowestAmount,
              max: _highestAmount,
              divisions: ((_highestAmount - _lowestAmount) ~/ 100000),
              value: _currentAmount,
              // label: formatter.format(_currentAmount),
              onChanged: (value) {
                setState(() {
                  _currentAmount = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '借款期限',
            style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 1),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          // 移除 Flexible 包裹
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 每行显示2个
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 50, // 设置子项高度为50像素
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // 禁止滚动，避免冲突
            children: <Widget>[
              _buildTermButton('1个月', 1),
              _buildTermButton('3个月', 3),
              _buildTermButton('6个月', 6),
              _buildTermButton('12个月', 12),
              _buildTermButton('18个月', 18),
            ],
          ),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: WGColors.ThemeColor,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoanApply()));
        },
        child: const Text(
          '立即申请',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTermButton(String text, int term) {
    bool isSelectedTerm = _selectedTerm == term;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelectedTerm ? Colors.white : Colors.black,
        backgroundColor: isSelectedTerm
            ? const Color.fromRGBO(250, 231, 192, 1)
            : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        side: isSelectedTerm
            ? null
            : const BorderSide(
                color: Color.fromRGBO(200, 29, 40, 1), // 边框颜色
                width: 0.5, // 边框宽度
              ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 15,
            color: isSelectedTerm
                ? const Color.fromRGBO(200, 29, 40, 1)
                : const Color.fromRGBO(102, 102, 102, 1)),
      ),
      onPressed: () {
        setState(() {
          _selectedTerm = term;
        });
      },
    );
  }

  Widget _buildTopSection(BuildContext context) {
    TextStyle tsStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    // 与之前相同
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: WGColors.ThemeColor, // 红色背景
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "恭喜您已完成所有的信息认证",
            style: tsStyle,
          ),
          Text(
            "请认领您的额",
            style: tsStyle,
          ),
        ],
      ),
    );
  }
}
