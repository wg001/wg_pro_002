import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('add todo'),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('wg'),
                  content: Text('This is a dialog message.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 关闭对话框
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              });
        },
      ),
      body: Container(
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                  // height: 0.4 * MediaQuery.of(context).size.height,
                  height: screenHeight * 0.1,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ListTile(
                              leading:
                                  Icon(Icons.bug_report, color: Colors.black),
                              title: Text(
                                "Report an Issue",
                                key: ValueKey(''),
                              ),
                              subtitle: Text(
                                "Having an issue ? Report it here",
                                key: ValueKey(''),
                              ),
                              //onTap: () => launchURL(ISSUE_URL)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(
                  // height: 0.4 * MediaQuery.of(context).size.height,
                  height: screenHeight * 0.4,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.bug_report, color: Colors.black),
                          title: Text(
                            "Report an Issue",
                            key: ValueKey(''),
                          ),
                          subtitle: Text(
                            "Having an issue ? Report it here",
                            key: ValueKey(''),
                          ),
                          //onTap: () => launchURL(ISSUE_URL)),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
