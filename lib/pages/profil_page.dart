import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings Page")),
      body: Center(
        child: Text("Welcome to the Profil Page!"),
      ),
    );
  }
}
