import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/pages/member_webview.dart';
import 'package:wg_pro_002/provider/guest_provider.dart';
import 'package:wg_pro_002/provider/navigation_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  String _version = "";
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _version = "${info.version}+${info.buildNumber}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Consumer<GuestProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Center(
                child: CircleAvatar(
                  radius: 50, // Adjust the size of the avatar
                  backgroundColor:
                      WGColors.ThemeColor, // Background color of the circle
                  child: Icon(
                    Icons.account_box, // Icon used for the avatar
                    size: 50, // Size of the icon
                    color: Colors.white, // Color of the icon
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    WgSetCell(
                      title: '会员',
                      clickCallBack: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MemberWebview(
                                  targetUrl: "", //todo replace target url
                                )));
                      },
                    ),
                    WgSetCell(
                      title: '修改资料',
                      clickCallBack: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .setCurrentIndex(0, refreshScreen: false);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainPage()));
                      },
                    ),
                    WgSetCell(
                      title: '帮助中心',
                      clickCallBack: () {},
                    ),
                    WgSetCell(
                      title: '关于',
                      text: _version,
                      clickCallBack: () {},
                    ),
                    const Gap(50),
                    ElevatedButton(
                      onPressed: () {
                        CommonUtils.showToast("Elevated Button Pressed");
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: WGColors.ThemeColor, // Text color
                        elevation: 5, // Button shadow
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Button border radius
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15), // Button padding
                      ),
                      child: const Text('Click Me!'),
                    ),
                    const Gap(600),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
