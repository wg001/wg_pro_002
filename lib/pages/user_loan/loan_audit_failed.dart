import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/widget/common_widget.dart';

class LoanAuditFailed extends StatefulWidget {
  const LoanAuditFailed({super.key});

  @override
  _LoanAuditFailedState createState() => _LoanAuditFailedState();
}

class _LoanAuditFailedState extends State<LoanAuditFailed> with CommonWidget {
  static const textStyle =
      TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 13);

  static const section2TextColor = Color.fromRGBO(168, 102, 55, 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_mainContent01(), const Gap(10), _mainContent02()],
    );
  }

  Widget _sectionContent1() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        children: <Widget>[
          const Gap(10),
          getDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Text(
                      "订单号: ",
                      style: textStyle,
                    ),
                    Text(
                      "24080000000xxx",
                      style: textStyle,
                    ),
                  ],
                ),
                const Gap(10),
                Row(children: [
                  Container(
                    width: MathUtils.screenWidth * 0.2,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: WGColors.ThemeColor, // 边框颜色
                          width: 0.5, // 边框宽度
                        )),
                    child: const Text(
                      Strings.LoanStatusAuditFailed,
                      style: TextStyle(color: WGColors.ThemeColor),
                    ),
                  ),
                ]),
                const Gap(20),
                const Row(
                  children: <Widget>[
                    Text(
                      "应还金额",
                      style: textStyle,
                    )
                  ],
                ),
                const Row(
                  children: <Widget>[
                    Text(
                      "60,000",
                    ),
                  ],
                ),
                const Gap(20),
                const Row(
                  children: <Widget>[
                    Text(
                      "最后还款日",
                      style: textStyle,
                    )
                  ],
                ),
                const Row(
                  children: <Widget>[
                    Text(
                      "2020.07.02",
                    ),
                  ],
                ),
                const Gap(20),
                _submitButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sectionContent2() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        children: <Widget>[
          const Gap(10),
          getDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Text(
                      "pinjaman maksimum",
                      style: TextStyle(color: section2TextColor, fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: <Widget>[
                    Text(
                      "10,000",
                      style: TextStyle(
                          color: section2TextColor,
                          fontSize: 45,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const Gap(20),
                _section2SubmitButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _section2SubmitButton() {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(234, 234, 234, 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: const Text(
          Strings.LoanButtonSection2,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _mainContent01() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color.fromRGBO(255, 255, 255, 1)),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Gap(20),
          Container(
              width: MathUtils.screenWidth * 0.5,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(250, 231, 192, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      Strings.LoanTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(201, 33, 42, 1), fontSize: 15),
                    ),
                  ])),
          _sectionContent1(),
          const Gap(10),
        ],
      ),
    );
  }

  Widget _mainContent02() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          color: Color.fromRGBO(255, 255, 255, 1)),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Gap(20),
          Container(
              width: MathUtils.screenWidth * 0.5,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(250, 231, 192, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      Strings.LoanSubTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(201, 33, 42, 1), fontSize: 15),
                    ),
                  ])),
          _sectionContent2(),
          const Gap(10),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: WGColors.ThemeColor,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: const Text(
          Strings.LoanButtonRepay,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
