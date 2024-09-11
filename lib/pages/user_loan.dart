import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/user_loan_detail/loan_audit_failed.dart';
import 'package:wg_pro_002/pages/user_loan_detail/loan_repay.dart';
import 'package:wg_pro_002/widget/common_widget.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';
import 'package:wg_pro_002/widget/custom_progress_bar.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';
import 'package:wg_pro_002/widget/wg_picker_tool.dart';

class UserLoan extends StatefulWidget {
  const UserLoan({super.key});

  @override
  _UserLoanState createState() => _UserLoanState();
}

class _UserLoanState extends State<UserLoan> with CommonWidget {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<UserInfoProvider>(context, listen: false).loadUserData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose(); // 确保父类的 dispose 方法被调用
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 在这里添加你的逻辑
            print("处理一些清理工作或保存数据等");
            // 然后返回到上一个页面
            Navigator.pop(context);
          },
        ),
        title: const Text(
          Strings.LoanBarTitle,
          style: TextStyle(color: Colours.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // 设置图标主题，包括回退按钮颜色
        backgroundColor: Colors.transparent, // 设置 AppBar 背景透明
        elevation: 0, // 移除阴影
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    WGColors.ThemeColor, // 从主题颜色开始
                    Color.fromRGBO(249, 249, 249, 1) // 渐变到白色
                  ],
                  stops: [0.3, 0.3],
                ),
              ),
            ),
          ),
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return Consumer<UserInfoProvider>(
      builder: (BuildContext context, userInfoProvider, Widget? child) {
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: _mainContent(),
              ),
              // 固定在右下角的按钮
            ],
          ),
        );
      },
    );
  }

  Widget _mainContent() {
    int routeIndex = 1;
    Widget content = Container();
    switch (routeIndex) {
      case 1:
        content = const LoanAuditFailed();
        break;
      default:
        content = const LoanRepay();
    }
    return content;
  }
}
