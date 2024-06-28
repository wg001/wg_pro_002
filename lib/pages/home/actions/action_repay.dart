import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/pages/home/actions/action_start.dart';

class HomePageRepayContent extends StatelessWidget {
  final HomeRet homePageData;

  HomePageRepayContent({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0), // 统一左右边距
          height: MathUtils.screenHeight * 0.3,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: buildTable(),
          ),
        ),
        SizedBox(height: 20),
        buildCard(),
      ],
    );
  }

  Widget buildTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        buildTableRow('Current Installment Number', 'Current Order Status'),
        buildTableRow('Current Installment Amount Due:', 'Current Installment Date Due'),
        // 更多行...
      ],
    );
  }

  TableRow buildTableRow(String leftText, String rightText) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(leftText, style: tableHeaderStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(rightText, style: tableTextStyle),
        ),
      ],
    );
  }

  Widget buildCard() {
    return Card(
      elevation: 0, // 移除 Card 阴影
      color: Colors.blue.withOpacity(0.5), // 设置卡片的背景色和透明度
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // 设置圆角的大小
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0), // 统一左右边距
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(240), // 适当调整以确保对齐
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(
              children: [
                TableCell(child: Text('Amount Due in Next Installment:', style: TextStyle(fontWeight: FontWeight.bold))),
                TableCell(child: Text(homePageData.userLoanInfo.installmentRepaymentData?.nextAmount ?? '')),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('Due Date in Next Installment:', style: TextStyle(fontWeight: FontWeight.bold))),
                TableCell(child: Text(homePageData.userLoanInfo.installmentRepaymentData?.nextRepayDate ?? '')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
