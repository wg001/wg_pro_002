import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/deposit/deposit_index.dart';
import 'package:wg_pro_002/pages/home_widget/home_head_main_content_no_auth.dart';
import 'package:wg_pro_002/pages/user_loan.dart';
import 'package:wg_pro_002/pages/user_loan/loan_option.dart';
import 'package:wg_pro_002/pages/user_points/points_mall.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  bool existLoan = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WGColors.ThemeColor,
      body: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: MathUtils.screenHeight * 0.1),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  width: MathUtils.screenWidth * 0.6,
                  height: MathUtils.screenWidth * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          '${Config.BASE_APP_ASSETS_PATH}home_main_img.png'),
                      fit: BoxFit.cover, // 覆盖整个容器
                    ),
                  ),
                ),
              ])),
          mainContent(context),
        ],
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          headBar(),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
            const Gap(30),
            _headMainContent(),
            const Gap(20),
            _middleContent(context),
            const SizedBox(height: 20),
            if (existLoan) _loanSection(context),
            _bottomSection(context),
          ])))
        ]));
  }

  Widget _loanSection(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 20), // Adjusts the position upwards
      child: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.orangeAccent,
            ),
            height: 70,
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to the top

                  children: <Widget>[
                    const Text(
                      Strings.HomeExistLoanDesc,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        //UserLoan
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserLoan()));
                      },
                      child: const Text(
                        Strings.HomeExistLoanCheck,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  Widget _depositAndBorrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildCard(
            '存款',
            Image.asset('${Config.BASE_APP_ASSETS_PATH}home_deposit.png'),
            const Color.fromRGBO(255, 250, 236, 1),
            () {
              CommonUtils.showToast('存款 Tapped');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DepositIndex()));
            },
          ),
          _buildCard(
              '借款',
              Image.asset('${Config.BASE_APP_ASSETS_PATH}home_borrow.png'),
              const Color.fromRGBO(245, 249, 255, 1), () {
            CommonUtils.showToast('借款 Tapped');
            // 这里可以添加导航到存款页面的代码
            CommonUtils.showToast('存款 Tapped');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoanOption()));
          }),
        ],
      ),
    );
  }

  Widget headBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 使子组件分布在左右两端
          children: <Widget>[
            const Text(
              'WUSH',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    CommonUtils.showToast("this is help");
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(10), // 可选：设置边角为圆角
                    ),
                    child: Center(
                      child: Image.asset(
                          '${Config.BASE_APP_ASSETS_PATH}home_help.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    CommonUtils.showToast("this is refresh");
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(10), // 可选：设置边角为圆角
                    ),
                    child: const Center(
                      child: Icon(Icons.cached_outlined),
                    ),
                  ),
                ),
              ],
            )
          ]),
    );
  }

  Widget _headMainContent() {
    Widget content = Container();
    String action = "";
    switch (action) {
      default:
        content = const HomeHeadMainContentNoAuth();
        break;
    }
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10), child: content);
  }

  Widget _middleContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Terdaftar, diawasi serta didukung oleh:",
                        style: TextStyle(color: Colours.white),
                      )
                    ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                    '${Config.BASE_APP_ASSETS_PATH}home_middle_img1.png'),
                Image.asset(
                    '${Config.BASE_APP_ASSETS_PATH}home_middle_img2.png'),
                Image.asset(
                    '${Config.BASE_APP_ASSETS_PATH}home_middle_img3.png'),
              ],
            )
          ],
        ));
  }

  Widget _buildCard(String title, Image image, Color color, Function() onTap) {
    return Center(
        child: Card(
            color: color, // 设置卡片的背景色
            shadowColor: Colors.black, // 设置阴影颜色
            elevation: 5, // 设置阴影的高度
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 设置边框圆角
            ),
            child: InkWell(
              onTap: onTap,
              splashColor: color.withOpacity(0.8), // 水波纹颜色
              highlightColor: WGColors.ThemeColor.withOpacity(1), // 高亮颜色在点击时展示
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [image, Text(title)],
                  )),
            )));
  }

  Widget _pointsSection(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft, // 设置对齐方式为左对齐
              child: Text(Strings.HomeMyPoints,
                  style: TextStyle(color: Color.fromRGBO(96, 32, 0, 1))),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              height: MathUtils.screenHeight * 0.1, // 添加一个高度值
              width: double.infinity, // 让容器宽度充满其父容器
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      '${Config.BASE_APP_ASSETS_PATH}home_bottom_bg_img.png'),
                  fit: BoxFit.fill, // 添加适当的填充模式
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          textAlign: TextAlign.left,
                          text: const TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                  text: "积分商城\n",
                                  style: TextStyle(
                                      color: Color.fromRGBO(96, 32, 0, 1),
                                      fontSize: 18)),
                              TextSpan(
                                  text: "积分可兑换",
                                  style: TextStyle(
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontSize: 13)),
                              TextSpan(
                                  text: "优惠券",
                                  style: TextStyle(
                                      color: Color.fromRGBO(225, 145, 87, 1),
                                      fontSize: 13)),
                              //
                            ],
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PointsMall()));
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18), // 设置圆角大小
                            ),
                            backgroundColor: Colours.white, // 可以设置背景颜色
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0), // 设置内边距
                          ),
                          child: const Text(
                            "积分兑换",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(96, 32, 0, 1), // 设置文本颜色
                            ),
                          ))
                    ],
                  ))),
        ),
      ],
    );
  }

  _bottomSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          _depositAndBorrow(context),
          const SizedBox(height: 10),
          _pointsSection(context),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Hot Line: 400-XXX-XXXX',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
