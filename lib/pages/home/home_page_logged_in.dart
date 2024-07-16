import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/pages/home/actions/action_repay.dart';
import 'package:wg_pro_002/pages/home/actions/action_start.dart';
import 'package:wg_pro_002/provider/home_page_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

// ignore: constant_identifier_names
const String HOME_ACTION_START = 'start';
const String HOME_ACTION_REPAY = 'repay';

class HomePageLoggedIn extends StatefulWidget {
  const HomePageLoggedIn({super.key});

  @override
  _HomePageLoggedInState createState() => _HomePageLoggedInState();
}

class _HomePageLoggedInState extends State<HomePageLoggedIn> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomePageProvider>(context, listen: false);
      provider.fetchHomePageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('add todo'),
        backgroundColor: Colors.orange,
        onPressed: () {
          provider.refreshData();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.zero,
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.homePageData != null
                  ? HomePageContent(
                      homePageData: provider.homePageData!,
                      refreshData: provider.refreshData,
                      isLoading: provider.isLoading)
                  : FailedLoad(),
        ),
      ),
    );
  }

  Widget FailedLoad() {
    return const Card(
      child: Text('failed load data'),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final HomeRet homePageData;
  final Function refreshData;
  final bool isLoading;

  const HomePageContent(
      {super.key,
      required this.homePageData,
      required this.refreshData,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 80, // 预留足够空间让Card重叠
                child: Card(
                  color: Colors.orange,
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                  child: ListTile(
                    title: Text("Welcome ${homePageData.userBaseInfo?.phone}"),
                    trailing: isLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () => refreshData(),
                            tooltip: 'Refresh Data',
                            color: Colors.blue,
                            iconSize: 30,
                          ),
                  ),
                ),
              ),
              // 其他列表项...
            ],
          ),
          Positioned(
            top: 60, // 调整这个值来控制重叠的部分
            left: 0,
            right: 0,
            child: buildActionBasedContent(homePageData), // 调用生成内容的函数
          ),
        ],
      ),
    );
  }

  Widget buildActionBasedContent(HomeRet data) {
    String action = data.userLoanInfo.action ?? 'default';
    Widget content;
    switch (action) {
      case HOME_ACTION_START:
        content = HomePageStartContent(homePageData: data);
        break;
      case HOME_ACTION_REPAY:
        content = HomePageRepayContent(homePageData: data);
        break;
      default:
        content = HomePageStartContent(homePageData: data);
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 246, 244, 244), // 设置容器背景色
        borderRadius: BorderRadius.circular(15), // 设置圆角
        boxShadow: [
          // 可选，如果你需要阴影效果
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.all(0), // 移除默认的ListView padding
        shrinkWrap: true, // 适应内部内容的高度
        children: <Widget>[
          const Gap(20), // 顶部间隔
          content, // 根据action显示相应内容
          const Gap(20), // 底部间隔
        ],
      ),
    );
  }
}
