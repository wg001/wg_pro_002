import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String id;

  DetailsPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page")),
      body: Center(
        child: Text("Welcome to the Details Page with ID: $id"),
      ),
    );
  }
}
