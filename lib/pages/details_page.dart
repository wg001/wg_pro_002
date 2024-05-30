import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final int id;

  DetailsPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page")),
      body: Center(
        child: Text("Viewing details for item $id"),
      ),
    );
  }
}
