import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/dao/loan_dao.dart';
import 'package:wg_pro_002/pages/home/actions/action_repay.dart';
import 'package:wg_pro_002/pages/home/actions/action_start.dart';
import 'package:wg_pro_002/redux/home_redux.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/logger_util.dart';

// ignore: constant_identifier_names
const String HOME_ACTION_START = 'start';
const String HOME_ACTION_REPAY = 'repay';

class HomePageLoggedIn extends StatefulWidget {
  const HomePageLoggedIn({Key? key}) : super(key: key);

  @override
  _HomePageLoggedInState createState() => _HomePageLoggedInState();
}

class _HomePageLoggedInState extends State<HomePageLoggedIn>
    with AutomaticKeepAliveClientMixin<HomePageLoggedIn> {
  @override
  void initState() {
    super.initState();
  }

  bool _isLoading = false;

  void _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    final store = StoreProvider.of<WGState>(context, listen: false);
    // 假设你需要从store更新数据
    store.dispatch(FetchHomePageDataFailureAction(''));
    store.dispatch(FetchHomePageDataAction());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final store = StoreProvider.of<WGState>(context, listen: false);
    final timeNow = DateTime.now();
    final lastFetchTime = store.state.lastFetchTime;
    LogUtils.logInfo('timeNow:$timeNow');
    LogUtils.logInfo('lastFetchTime:$lastFetchTime');
    if (lastFetchTime != null) {
      LogUtils.logInfo('diff_time:${timeNow.difference(lastFetchTime)}');
    }
    if (lastFetchTime == null ||
        timeNow.difference(lastFetchTime) > const Duration(seconds: 10) ||
        store.state.homePageData == null) {
      store.dispatch(FetchHomePageDataAction());
      store.dispatch(FetchHomePageDataFailureAction(""));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StoreConnector<WGState, HomeRet?>(
        converter: (store) => store.state.homePageData,
        builder: (context, homePageData) {
          if (homePageData == null) {
            return Center(child: CircularProgressIndicator());
          }
          return HomePageContent(
              homePageData: homePageData,
              refreshData: _refreshData,
              isLoading: _isLoading);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageContent extends StatelessWidget {
  final HomeRet homePageData;
  final Function refreshData;
  final bool isLoading;

  HomePageContent(
      {required this.homePageData,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                  child: ListTile(
                    title: Text("Welcome ${homePageData.userBaseInfo?.phone}"),
                    trailing: isLoading
                        ? CircularProgressIndicator()
                        : IconButton(
                            icon: Icon(Icons.refresh),
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
        color: Color.fromARGB(255, 246, 244, 244), // 设置容器背景色
        borderRadius: BorderRadius.circular(15), // 设置圆角
        boxShadow: [
          // 可选，如果你需要阴影效果
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.all(0), // 移除默认的ListView padding
        shrinkWrap: true, // 适应内部内容的高度
        children: <Widget>[
          Gap(20), // 顶部间隔
          content, // 根据action显示相应内容
          Gap(20), // 底部间隔
        ],
      ),
    );
  }
}
