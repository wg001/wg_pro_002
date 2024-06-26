import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/dao/loan_dao.dart';
import 'package:wg_pro_002/redux/home_redux.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/logger_util.dart';

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
    // // 在组件初始化时触发异步操作
    // StoreProvider.of<WGState>(context).dispatch(FetchHomePageDataAction());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在 didChangeDependencies 中触发异步操作
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
      LogUtils.logInfo('hittttt');
      store.dispatch(FetchHomePageDataAction());
      store.dispatch(FetchHomePageDataFailureAction(""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<WGState, HomeRet?>(
        converter: (store) => store.state.homePageData,
        builder: (context, homePageData) {
          if (homePageData == null) {
            return Center(child: CircularProgressIndicator());
          }
          return HomePageContent(homePageData: homePageData);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageContent extends StatelessWidget {
  final HomeRet homePageData;

  HomePageContent({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange, // 确保 Card 背景颜色为透明
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // 设置统一的边距
          children: <Widget>[
            Card(
                margin: EdgeInsets.zero,
                elevation: 0, // 移除 Card 阴影
                child: ListTile(
                  // leading: Icon(Icons.business, color: Colors.black),
                  title:
                      Text("Welcome Sir:${homePageData.userBaseInfo?.phone}"),
                  // subtitle: Text(
                  //     "Find out more about our company. ${homePageData.userLoanInfo.remindTip}"),
                  trailing: ElevatedButton(
                    onPressed: () => StoreProvider.of<WGState>(context)
                        .dispatch(FetchHomePageDataAction()),
                    child: Text('Refresh'),
                  ),
                )),
            // Card(
            //   elevation: 0, // Remove Card shadow
            //   child: Padding(
            //     padding: const EdgeInsets.all(0),
            //     child: Html(
            //       data: homePageData.productCharacteristics,
            //     ),
            //   ),
            // ),
            SizedBox(height: MathUtils.screenHeight * 0.02),
            Column(
              children: <Widget>[
                Container(
                  height: MathUtils.screenHeight * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1), // 透明背景色
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(1), // 描述列宽度
                        1: FlexColumnWidth(1), // 数值列宽度
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 8, bottom: 8),
                              child: Text(
                                  homePageData.userLoanInfo.loanMaxAmountDesc ??
                                      '',
                                  style: TextStyle(fontSize: 14)),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 8, bottom: 8),
                                child: Text(
                                    '₱ ${homePageData.userLoanInfo.loanMaxAmount}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left)),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 16, bottom: 8),
                              child:
                                  Text('APR:', style: TextStyle(fontSize: 16)),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 16, bottom: 8),
                                child: Text(
                                    homePageData.userLoanInfo.loanApr ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left)),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 16, bottom: 8),
                              child: Text('Loan Period:',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 16, bottom: 8),
                                child: Text(
                                    homePageData.userLoanInfo.loanPeriod ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    CommonUtils.showToast("to apply now");
                  },
                  child: Container(
                    width: MathUtils.screenWidth * 0.5, // 设置按钮的宽度
                    alignment: Alignment.center, // 居中对齐文本
                    child: Text('Apply'),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // 文本颜色
                    backgroundColor: Colors.blue, // 背景色
                  ),
                ),
              ],
            ),
            // 其他内容
          ],
        ));
  }
}
