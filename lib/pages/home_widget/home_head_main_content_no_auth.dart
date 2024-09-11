import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/guest/login_or_register.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_1.dart';

class HomeHeadMainContentNoAuth extends StatelessWidget {
  const HomeHeadMainContentNoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height * 0.2;
    return Container(
      height: totalHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 10, top: 10, bottom: totalHeight * 0.4), // 为顶部图片添加适当的填充
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: totalHeight * 0.1,
                child:
                    Image.asset("${Config.BASE_APP_ASSETS_PATH}home_vip.png"),
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 255, 241, 1),
                        Color.fromRGBO(234, 218, 200, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Image.asset(
                                '${Config.BASE_APP_ASSETS_PATH}home_ellipses.png'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              Strings.HomeNoLoginText,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(100, 100, 100, 1)),
                            )
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: totalHeight * 0.6,
                            height: totalHeight * 0.2,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(233, 179, 36, 1),
                                  Color.fromRGBO(227, 156, 28, 1)
                                ], // 渐变色数组
                                begin: Alignment.topCenter, // 渐变开始位置
                                end: Alignment.bottomCenter, // 渐变结束位置
                              ),
                              borderRadius: BorderRadius.circular(20), // 圆角
                            ),
                            child: TextButton(
                              onPressed: () {
                                _pageRouter(context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  // 形状
                                  borderRadius:
                                      BorderRadius.circular(30), // 圆角大小
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 0), // 内边距
                                textStyle:
                                    const TextStyle(fontSize: 15), // 字体大小
                              ),
                              child: const Text(
                                  Strings.HomeToRegisterOrLogin), // 按钮文本
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }

  void _pageRouter(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => const LoginOrRegister()));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UserInfoPage1()));
  }
}
