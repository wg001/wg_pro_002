import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_1.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

const TextStyle tableTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
const TextStyle tableHeaderStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

class HomePageStartContent extends StatelessWidget {
  final HomeRet homePageData;

  HomePageStartContent({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MathUtils.screenHeight * 0.3,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: buildInfoTable(context),
        ),
        SizedBox(height: 20),
        buildOpenContainerButton(context),
      ],
    );
  }

  Widget buildInfoTable(BuildContext context) {
    return Center(
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          buildTableRow(homePageData.userLoanInfo.loanMaxAmountDesc ?? '',
              '₱ ${homePageData.userLoanInfo.loanMaxAmount}'),
          buildTableRow('APR:', homePageData.userLoanInfo.loanApr ?? ''),
          buildTableRow(
              'Loan Period:', homePageData.userLoanInfo.loanPeriod ?? ''),
        ],
      ),
    );
  }

  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 8, bottom: 8),
          child: Text(label, style: tableHeaderStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 8, bottom: 8),
          child: Text(value, style: tableTextStyle, textAlign: TextAlign.left),
        ),
      ],
    );
  }

  // Widget buildOpenContainerButton(BuildContext context) {
  //   return OpenContainer(
  //     transitionType: ContainerTransitionType.fade,
  //     openBuilder: (BuildContext context, VoidCallback _) {
  //       return NavigatorUtils.pageContainer(UserInfoPage1(), context);
  //     },
  //     closedElevation: 6.0,
  //     // closedShape: const RoundedRectangleBorder(
  //     //   borderRadius: BorderRadius.all(Radius.circular(28)), // 修改圆角大小为28
  //     // ),
  //     // closedColor: Theme.of(context).colorScheme.secondary,
  //     closedBuilder: (BuildContext context, VoidCallback openContainer) {
  //       return SizedBox(
  //         width: MathUtils.screenWidth * 0.3,
  //         // height: 50, // 确保高度足以显示圆角
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.orange, // 设置按钮的背景颜色
  //             foregroundColor: Colors.white, // 设置按钮文字颜色
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5), // 显著增加圆角的半径
  //             ),
  //             padding:
  //                 EdgeInsets.symmetric(horizontal: 2, vertical: 2), // 设置按钮内部的填充
  //             elevation: 10, // 设置阴影
  //           ),
  //           onPressed: openContainer,
  //           child: Text("Apply"), // Button text
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget buildOpenContainerButton(BuildContext context) {
  return SizedBox(
    width: MathUtils.screenWidth * 0.3,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // 设置按钮的背景颜色
        foregroundColor: Colors.white, // 设置按钮文字颜色
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // 设置圆角
        ),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2), // 设置按钮内部的填充
        elevation: 10, // 设置阴影
      ),
      onPressed: () => _navigateToUserInfoPage1(context),
      child: Text("Apply"), // Button text
    ),
  );
}

void _navigateToUserInfoPage1(BuildContext context) {
  Navigator.of(context).push(_createRoute(context));
}

Route _createRoute(BuildContext context) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => UserInfoPage1(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

}
