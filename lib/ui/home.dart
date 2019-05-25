import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/shared_preference.dart';
import 'package:mobilefinal2/read_write_file/file.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<HomeScreen> {
  String quote = "today is my day";
  String name = "FIRSTNAME LASTNAME";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get name from preferene
    Future<String> prefname = SharePreference.getName();
    prefname.then((value) {
      setState(() {
        if (value != null) name = value;
        print(name);
      });
    });
    // read file
    Future<String> text = FileManager.fileManager.readFile();
    text.then((value) {
      setState(() {
        if (value != null) quote = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "Hello $name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "this is my quote " + '\"$quote\"',
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 350,
            buttonColor: Colors.white,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/profile");
              },
              child: Text("Profile Setup".toUpperCase()),
            ),
          ),
          ButtonTheme(
            minWidth: 350,
            buttonColor: Colors.white,
            child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/friend");
                },
                child: Text("My Friends".toUpperCase())),
          ),
          ButtonTheme(
            minWidth: 350,
            buttonColor: Colors.white,
            child: RaisedButton(
                onPressed: () {
                  SharePreference.clear();
                  // Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: Text("Sign Out".toUpperCase())),
          )
        ],
      ),
    );
  }
}
