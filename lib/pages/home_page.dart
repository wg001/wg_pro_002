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
        title: const Text("Home Page"),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "init home page",
        key: const ValueKey('add todo'),
        backgroundColor: Colors.orange,
        onPressed: () => _showDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<bool>(
        future: Provider.of<UserAuthNotifier>(context, listen: false)
            .checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          bool isLoggedIn = snapshot.data ?? false;
          return Container(
            child: Center(
              child: isLoggedIn
                  ? const HomePageLoggedIn()
                  : const HomePageLoggedOut(),
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
          title: const Text('Dialog Title'),
          content: const Text('This is a dialog message.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
