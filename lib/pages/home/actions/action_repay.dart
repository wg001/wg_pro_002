import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          // margin: const EdgeInsets.symmetric(horizontal: 5.0), // 统一左右边距
          height: MathUtils.screenHeight * 0.3,
          margin: const EdgeInsets.symmetric(
              horizontal: 5.0), // Ensure margin is set here

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: buildTable(),
          ),
        ),
        SizedBox(height: 20),
        buildCard(),
        buildButton(),
      ],
    );
  }

  Padding buildButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 平均分配空间
        children: <Widget>[
          SizedBox(
            width: MathUtils.screenWidth*0.3,
            child: ElevatedButton(
              onPressed: () {
                // 按钮1的点击事件
                print("Button 1 clicked");
              },
              child: FittedBox(
                  fit: BoxFit.scaleDown, child: Text('settle in installments')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // 设置按钮的背景颜色
                foregroundColor: Colors.white, // 设置按钮文字颜色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 明确设置圆角为1
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 2, vertical: 2), // 设置按钮内部的填充
                elevation: 10, // 设置阴影
              ),
            ),
          ),
          SizedBox(
              width: MathUtils.screenWidth*0.3,
              child: ElevatedButton(
                onPressed: () {
                  // 按钮1的点击事件
                  print("full settlement");
                },
                child: FittedBox(
                    fit: BoxFit.scaleDown, child: Text('full settlement')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // 设置按钮的背景颜色
                  foregroundColor: Colors.white, // 设置按钮文字颜色
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // 明确设置圆角为1
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 2, vertical: 2), // 设置按钮内部的填充
                  elevation: 10, // 设置阴影
                ),
              )),
          if (homePageData.userLoanInfo.displayPostponementButton ?? false)
            // 条件判断
            SizedBox(
                width: MathUtils.screenWidth*0.3,
                child: ElevatedButton(
                  onPressed: () {
                    // 按钮1的点击事件
                    print("Button 3 clicked");
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // 缩小内容以确保全部显示
                    child: Text('Extended Settlement'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // 设置按钮的背景颜色
                    foregroundColor: Colors.white, // 设置按钮文字颜色
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // 明确设置圆角为1
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 2, vertical: 2), // 设置按钮内部的填充
                    elevation: 10, // 设置阴影
                  ),
                )),
        ],
      ),
    );
  }

  Widget buildTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 1, // Thickness of the line
          color: const Color.fromARGB(255, 243, 242, 242)!
              .withOpacity(0.5), // Color of the line
          style: BorderStyle.solid, // Style of the line
        ),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        buildTableRow('Current Installment Number', 'Current Order Status'),
        buildTableRow(
            homePageData.userLoanInfo.installmentRepaymentData?.currentPeriod ??
                '',
            homePageData.userLoanInfo.status ?? '',
            align: TextAlign.center),
        buildTableRow(
            'Current Installment Amount Due:', 'Current Installment Date Due'),
        buildTableRow(
            homePageData.userLoanInfo.installmentRepaymentData?.currentAmount ??
                '',
            homePageData
                    .userLoanInfo.installmentRepaymentData?.currentRepayDate ??
                '',
            align: TextAlign.center),
      ],
    );
  }

  TableRow buildTableRow(String leftText, String rightText,
      {TextAlign align = TextAlign.center}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                leftText,
                style: tableHeaderStyle,
                textAlign: align,
              ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                rightText,
                style: tableHeaderStyle,
                textAlign: align,
              ))),
        ),
      ],
    );
  }

  Widget buildCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: 5.0), // Ensure margin is set here
      elevation: 0, // 移除 Card 阴影
      color: Colors.white.withOpacity(1), // 设置卡片的背景色和透明度
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0), // 设置圆角的大小
      ),
      // margin: const EdgeInsets.symmetric(horizontal: 16.0), // 统一左右边距
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            // 0: FixedColumnWidth(), // 适当调整以确保对齐
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(
              children: [
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        //  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Amount Due in Next Installment:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ))),
                TableCell(
                    child: Text(
                        homePageData.userLoanInfo.installmentRepaymentData
                                ?.nextAmount ??
                            '',
                        textAlign: TextAlign.center)),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Due Date in Next Installment:',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                TableCell(
                    child: Text(
                        homePageData.userLoanInfo.installmentRepaymentData
                                ?.nextRepayDate ??
                            '',
                        textAlign: TextAlign.center)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
