import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String,dynamic>? Params;

  DetailsPage({super.key, this.Params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page")),
      body: Center(
        child: Text("Welcome to the Details Page with ID: ${this.Params}"),
      ),
    );
  }
}
