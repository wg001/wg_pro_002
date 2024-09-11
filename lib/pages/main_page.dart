import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/app_colors.dart';
import 'package:wg_pro_002/common/text_styles.dart';
import 'package:wg_pro_002/common/font_size.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/pages/details_page.dart';
import 'package:wg_pro_002/pages/forget_password_page.dart';
import 'package:wg_pro_002/pages/home_page.dart';
import 'package:wg_pro_002/pages/mine_page.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/provider/navigation_provider.dart';

class MainPage extends StatelessWidget {
  static const String sName = "main";

  MainPage({super.key});
  final _pages = [
    HomePage(),
    const MinePage(),
  ];
  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    // final currentIndex = Provider.of<NavigationProvider>(context).currentIndex;
    MathUtils.init(context);
    return Scaffold(
      body: _pages.elementAt(navigationProvider.currentIndex),
      bottomNavigationBar: Container(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 40,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: navigationProvider.currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => navigationProvider.setCurrentIndex(index),

          showUnselectedLabels: true,
          iconSize: getSize(24),
          selectedItemColor: WGColors.ThemeColor, //Pallete.orangePrimary,
          selectedLabelStyle: TextStyles.bodySmallMedium
              .copyWith(fontSize: getFontSize(FontSizes.small)),
          unselectedItemColor: Pallete.neutral50,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
                // icon: Image.asset(
                //     // '${Config.BASE_APP_ASSETS_PATH}me_no_selected.png',
                //     navigationProvider.currentIndex != 0
                //         ? '${Config.BASE_APP_ASSETS_PATH}me_no_selected.png'
                //         : '${Config.BASE_APP_ASSETS_PATH}phone_pause.png',
                //     width: 24,
                //     height: 24) // 确保提供正确的路径和尺寸
                icon: Icon(Icons.person),
                label: "Me"),
          ],
          elevation: 0,
        ),
      ),
    );
  }
}
