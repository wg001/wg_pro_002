import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/dao/loan_dao.dart';

class HomePageLoggedIn extends StatefulWidget {
  const HomePageLoggedIn({Key? key}) : super(key: key);

  @override
  _HomePageLoggedInState createState() => _HomePageLoggedInState();
}

class _HomePageLoggedInState extends State<HomePageLoggedIn> {
  bool isLoading = false;
  String? welcomeMessage;
  List<Issue>? issues;
  dynamic? Ret;

  @override
  void initState() {
    super.initState();
    isLoading = true; // Set loading to true before starting the fetch.
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      var result = await LoanDao.getPageIndex();
      setState(() {
        Ret = result.data;
        isLoading = false;
      });
      print("Data Retrieved: ${Ret['user_base_info']['phone']}");
    } catch (e) {
      setState(() {
        isLoading =
            false; // Ensures the loading state is updated even on failure.
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                SizedBox(
                    height: MathUtils.screenHeight * 0.1,
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.bug_report, color: Colors.black),
                        title: Text(welcomeMessage ?? "Default Welcome"),
                        subtitle: Text(
                            "Welcome ${Ret?['user_base_info']?['phone'] ?? 'Guest'}!!!"),
                      ),
                    )) // Additional UI elements here
              ],
            ),
    );
  }
}

class Issue {
  final String title;
  final String description;

  Issue(this.title, this.description);
}
