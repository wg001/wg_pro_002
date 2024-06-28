import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

const TextStyle tableTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
const TextStyle tableHeaderStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

class HomePageStartContent extends StatelessWidget {
  final HomeRet homePageData;

  HomePageStartContent({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    // 根据 homePageData 构建特别优惠的UI
    return Column(
      children: <Widget>[
        Container(
          height: MathUtils.screenHeight * 0.3,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1), // 透明背景色
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(1), // 描述列宽度
                1: FlexColumnWidth(1), // 数值列宽度
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 8, bottom: 8),
                      child: Text(
                          homePageData.userLoanInfo.loanMaxAmountDesc ?? '',
                          style: TextStyle(fontSize: 14)),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 8, bottom: 8),
                        child: Text(
                            '₱ ${homePageData.userLoanInfo.loanMaxAmount}',
                            style: tableTextStyle,
                            textAlign: TextAlign.left)),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 16, bottom: 8),
                      child: Text('APR:', style: tableHeaderStyle),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 16, bottom: 8),
                        child: Text(homePageData.userLoanInfo.loanApr ?? '',
                            style: tableTextStyle, textAlign: TextAlign.left)),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 16, bottom: 8),
                      child: Text('Loan Period:', style: tableHeaderStyle),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 16, bottom: 8),
                        child: Text(homePageData.userLoanInfo.loanPeriod ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: _onApplyPressed,
          child: Container(
            width: MathUtils.screenWidth * 0.5, // 设置按钮的宽度
            alignment: Alignment.center, // 居中对齐文本
            child: Text('Apply'),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, // 文本颜色
            backgroundColor: Colors.blue, // 背景色
          ),
        ),
      ],
    );
  }

  void _onApplyPressed() {
    CommonUtils.showToast("Applying now");
    // 进一步的处理逻辑
  }
}
