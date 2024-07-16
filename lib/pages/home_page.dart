import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/provider/user_auth_provider.dart';
import 'package:wg_pro_002/pages/home/home_page_logged_in.dart';
import 'package:wg_pro_002/pages/home/home_page_logged_out.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('add todo'),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
        onPressed: () => _showDialog(context),
      ),
      body: FutureBuilder<bool>(
        future: Provider.of<UserAuthNotifier>(context, listen: false).checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          bool isLoggedIn = snapshot.data ?? false;
          return Container(
            child: Center(
              child: isLoggedIn ? HomePageLoggedIn() : HomePageLoggedOut(),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog Title'),
          content: Text('This is a dialog message.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
