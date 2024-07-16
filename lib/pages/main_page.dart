import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/app_colors.dart';
import 'package:wg_pro_002/common/text_styles.dart';
import 'package:wg_pro_002/common/font_size.dart';
import 'package:wg_pro_002/pages/details_page.dart';
import 'package:wg_pro_002/pages/forget_password_page.dart';
import 'package:wg_pro_002/pages/home_page.dart';
import 'package:wg_pro_002/pages/profil_page.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/provider/navigation_provider.dart';

class MainPage extends StatelessWidget {
  static const String sName = "main";

  MainPage({super.key});
  final _pages = [
    const HomePage(),
    const DetailsPage(),
    const ForgetPasswordPage(),
    const ProfilPage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<NavigationProvider>(context).currentIndex;
    MathUtils.init(context);
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
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
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          iconSize: getSize(24),
          selectedItemColor: Pallete.orangePrimary, //Pallete.orangePrimary,
          selectedLabelStyle: TextStyles.bodySmallMedium
              .copyWith(fontSize: getFontSize(FontSizes.small)),
          unselectedItemColor: Pallete.neutral50,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Cart",
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble), label: "Messenger"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profil"),
          ],
          elevation: 0,
        ),
      ),
    );
  }
}
