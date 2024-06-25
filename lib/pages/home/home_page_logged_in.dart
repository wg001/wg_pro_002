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

class HomePageLoggedIn extends StatefulWidget {
  const HomePageLoggedIn({Key? key}) : super(key: key);

  @override
  _HomePageLoggedInState createState() => _HomePageLoggedInState();
}

class _HomePageLoggedInState extends State<HomePageLoggedIn> {
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
    StoreProvider.of<WGState>(context).dispatch(FetchHomePageDataAction());
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
}

class HomePageContent extends StatelessWidget {
  final HomeRet homePageData;

  HomePageContent({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange, // 确保 Card 背景颜色为透明
        child: ListView(
          children: <Widget>[
            Card(
                elevation: 0, // 移除 Card 阴影
                child: ListTile(
                  leading: Icon(Icons.business, color: Colors.black),
                  title:
                      Text("Welcome Sir:${homePageData.userBaseInfo?.phone}"),
                  subtitle: Text(
                      "Find out more about our company. ${homePageData.userLoanInfo.remindTip}"),
                  trailing: ElevatedButton(
                    onPressed: () => Fluttertoast.showToast(msg: "hello"),
                    child: Text('LoginOut'),
                  ),
                )),
            Card(
              elevation: 0, // Remove Card shadow
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Html(
                  data: homePageData.productCharacteristics,
                ),
              ),
            ),
            // 其他内容
          ],
        ));
  }
}
