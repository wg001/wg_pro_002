import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/widget/custom_dropdown.dart';
import 'package:wg_pro_002/widget/input_widget.dart';

class UserInfoPage1 extends StatefulWidget {
  static const String sName = "userInfoPage1";
  const UserInfoPage1({super.key});

  @override
  _UserInfoPage1State createState() => _UserInfoPage1State();
}

class _UserInfoPage1State extends State<UserInfoPage1>
    with AutomaticKeepAliveClientMixin<UserInfoPage1> {
  @override
  bool get wantKeepAlive => true;

  late UserInfo userInfo;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    DataResult res = await UserDao.getUserInfo();
    if (res.result && res.data is UserInfo) {
      userInfo = res.data as UserInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'HomePage1',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )),
      body: Column(children: <Widget>[
        buildTable(),
      ]),
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
          color: Color.fromARGB(255, 255, 255, 255)!
              .withOpacity(0.5), // Color of the line
          style: BorderStyle.solid, // Style of the line
        ),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        buildTableRow('Please Input Your ID', InputWidget()),
        // buildTableRow('Please Select Gender', CustomDropdown(null,)),
      ],
    );
  }

  TableRow buildTableRow(String leftText, Widget item,
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
                textAlign: align,
              ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: item,
        ),
      ],
    );
  }
}
