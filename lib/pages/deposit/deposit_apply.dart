import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wg_pro_002/pages/deposit/deposit_submit.dart';
import 'package:wg_pro_002/widget/wg_custom_thum_shape.dart';

class DepositApply extends StatefulWidget {
  const DepositApply({super.key});

  @override
  _DepositApplyState createState() => _DepositApplyState();
}

class _DepositApplyState extends State<DepositApply> {
  int _selectedTerm = 6; // Default term
  final double _highestAmount = 100000000;
  final double _lowestAmount = 10000000;
  late double _currentAmount = _lowestAmount; // Initialize here

  final formatter = NumberFormat("#,##0");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '存款服务',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置回退图标的颜色
        ),
        // backgroundColor: WGColors.ThemeColor,
      ),
      body: _mainContent(context),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  _amountChoose(context),
                  _periodChoose(context),
                  _submitButton(context),
                ],
              )),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(201, 33, 42, 1),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('确认',
            style: TextStyle(
                fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1))),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DepositSubmit()));
        },
      ),
    );
  }

  Widget _amountChoose(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(225, 142, 85, 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('储蓄金额',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white))
                  ])),
          Text(formatter.format(_currentAmount),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color.fromRGBO(241, 241, 241, 1),
              inactiveTrackColor: const Color.fromRGBO(193, 96, 30, 1),
              trackHeight: 3.0,
              thumbColor: const Color.fromARGB(255, 233, 233, 233),
              thumbShape: const WgCustomThumShape(),
              tickMarkShape: SliderTickMarkShape.noTickMark, // 添加这行来隐藏刻度点
            ),
            child: Slider(
              min: _lowestAmount,
              max: _highestAmount,
              divisions: 18,
              value: _currentAmount,
              // label: _currentAmount.toStringAsFixed(0),
              onChanged: (value) {
                setState(() {
                  _currentAmount = value;
                });
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatter.format(_lowestAmount.toInt()),
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1), fontSize: 15),
                  ),
                  Text(formatter.format(_highestAmount),
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 15))
                ],
              )),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _periodChoose(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('储蓄期限',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black))
                  ])),
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
          )
        ],
      ),
    );
  }

  Widget _buildTermButton(String text, int term) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: _selectedTerm == term ? Colors.white : Colors.black,
        backgroundColor: _selectedTerm == term ? Colors.orange : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(text),
      onPressed: () {
        setState(() {
          _selectedTerm = term;
        });
      },
    );
  }
}
