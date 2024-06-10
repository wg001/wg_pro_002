import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_pro_002/redux/login_redux.dart';
import 'package:wg_pro_002/redux/wg_state.dart';

class LoginPage extends StatefulWidget {
  static const String sName = 'login';
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginBLoC {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController validCodeController = TextEditingController();

  bool isButtonDisabled = false;
  int countdown = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _loadCountdown();
  }

  void startTimer() {
    try {
      setState(() {
        isButtonDisabled = true;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        try {
          setState(() {
            if (countdown > 0) {
              countdown--;
              _saveCountdown(countdown);
            } else {
              timer.cancel();
              countdown = 60;
              isButtonDisabled = false;
              _saveCountdown(countdown);
            }
          });
        } catch (e, stackTrace) {
          print('Caught exception in Timer: $e');
          print('Stack trace: $stackTrace');
        }
      });
    } catch (e, stackTrace) {
      print('Caught exception in startTimer: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> _loadCountdown() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? savedCountdown = prefs.getInt('countdown');
      bool? savedIsButtonDisabled = prefs.getBool('isButtonDisabled');
      if (savedCountdown != null && savedIsButtonDisabled != null) {
        setState(() {
          countdown = savedCountdown;
          isButtonDisabled = savedIsButtonDisabled;
          if (isButtonDisabled) {
            startTimer();
          }
        });
      }
    } catch (e, stackTrace) {
      print('Caught exception in _loadCountdown: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> _saveCountdown(int countdown) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('countdown', countdown);
      await prefs.setBool('isButtonDisabled', isButtonDisabled);
    } catch (e, stackTrace) {
      print('Caught exception in _saveCountdown: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    validCodeController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          color: Colors.orange,
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: Colors.white,
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.all(10.0)),
                    TextField(
                      controller: phoneController,
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
                            controller: validCodeController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "请输入验证码",
                              icon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: isButtonDisabled
                              ? null
                              : () {
                                  Fluttertoast.showToast(
                                    msg: '验证码已发送',
                                    gravity: ToastGravity.CENTER,
                                    toastLength: Toast.LENGTH_SHORT,
                                  );
                                  startTimer();
                                },
                          child:
                              Text(isButtonDisabled ? '$countdown 秒' : '获取验证码'),
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
                              textStyle: const TextStyle(color: Colors.orange),
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: loginIn,
                            child: Text(
                              "登陆",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
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
      ),
    );
  }
}

mixin LoginBLoC on State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController validCodeController = TextEditingController();

  String? _phone = "";

  String? _validcode = "";

  @override
  void initState() {
    super.initState();
    _initState();
    phoneController.addListener(_phoneChange);
    validCodeController.addListener(_validcodeChange);
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.removeListener(_phoneChange);
    validCodeController.removeListener(_validcodeChange);
  }

  _phoneChange() {
    _phone = phoneController.text;
  }

  _validcodeChange() {
    _validcode = validCodeController.text;
  }

  _initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _phone = prefs.getString("phone");
    String? _validcode = prefs.getString("validcode");
    // _phone = await (prefs.get("phone") as Future<String?>);
    // _validcode = await (prefs.get("validcode") as Future<String?>);
    phoneController.value = TextEditingValue(text: _phone ?? "");
    validCodeController.value = TextEditingValue(text: _validcode ?? "");
  }

  loginIn() async {
    if (_phone == null || _phone!.isEmpty) {
      return;
    }
    if (_validcode == null || _validcode!.isEmpty) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("validcode", _validcode!);
    await prefs.setString("phone", _phone!);
    print("dodo action");

    ///通过 redux 去执行登陆流程
    StoreProvider.of<WGState>(context)
        .dispatch(LoginAction(context, _phone, _validcode));
  }
}
