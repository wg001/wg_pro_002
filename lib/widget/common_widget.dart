import 'package:flutter/material.dart';
import 'package:wg_pro_002/config/colors.dart';

mixin CommonWidget {
  final TableRowColor = const Color.fromRGBO(255, 255, 255, 1);
  Widget getRowTitle(String title) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 1), fontSize: 14),
            ),
          ],
        ));
  }

  Widget getDivider() {
    return const Divider(
      color: Color.fromRGBO(250, 231, 192, 1),
      thickness: 0.6,
    );
  }

  // Widget getIdFrontDialogContent(){
  //   return
  // }
}
