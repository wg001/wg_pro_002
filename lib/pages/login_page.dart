import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/provider/user_auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String sName = 'login';

  bool isButtonDisabled = false;
  int countdown = 60;
  Timer? timer;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserAuthNotifier>(
        create: (context) => UserAuthNotifier(),
        child: Consumer<UserAuthNotifier>(
            builder: (BuildContext context, UserAuthNotifier userAuthModel,
                    Widget? child) =>
                Scaffold(
                  body: Container(
                    color: Colors.orange,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Card(
                          elevation: 5.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          color: Colors.white,
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                onChanged: (value) =>
                                    userAuthModel.updatePhone(value),
                                decoration: const InputDecoration(
                                  hintText: "请输入用户名",
                                  icon: Icon(Icons.person),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(30.0)),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) =>
                                          userAuthModel.updateValidCode(value),
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: "请输入验证码",
                                        icon: Icon(Icons.lock),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: userAuthModel.isButtonDisabled
                                        ? null
                                        : () {
                                            Fluttertoast.showToast(
                                              msg: '验证码已发送',
                                              gravity: ToastGravity.CENTER,
                                              toastLength: Toast.LENGTH_SHORT,
                                            );
                                            userAuthModel.startTimer();
                                          },
                                    child: Text(userAuthModel.isButtonDisabled
                                        ? '${userAuthModel.countdown} 秒'
                                        : '获取验证码'),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(15.0)),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return SizedBox(
                                    height: 40,
                                    width: constraints.maxWidth * 0.6,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: const TextStyle(
                                            color: Colors.orange),
                                        backgroundColor: Colors.orange,
                                      ),
                                      onPressed: () =>
                                          userAuthModel.login(context),
                                      child: const Text(
                                        "登陆",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const Padding(padding: EdgeInsets.all(15.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
