import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilefinal2/db/db.dart';
import 'package:mobilefinal2/model/shared_preference.dart';
import 'package:mobilefinal2/model/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  Myform createState() {
    return Myform();
  }
}

class Myform extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> textControl = [
    new TextEditingController(),
    new TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("LOGIN")),
        body: Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: Image.network(
                    "https://s3-ap-southeast-1.amazonaws.com/codesanook-static/uploaded/2016/5/15/1463315588975-primary-key.png?t=1463315627390",
                    height: 200,
                  ),
                  margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
                ),
                Container(
                  child: TextFormField(
                    controller: textControl[0],
                    decoration: InputDecoration(
                      labelText: "User Id",
                      hintText: "User Id",
                      icon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (value) => print(value),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "กรุณาระบุ user";
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                Container(
                  child: TextFormField(
                    controller: textControl[1],
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "password",
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    onSaved: (value) => print(value),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "กรุณาระบุ password";
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                Container(
                  child: RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      print(_formKey.currentState.validate());
                      if (!_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Please fill out this form"),
                        ));
                      } else {
                        List<User> users = await DBProvider.db.getAllUser();
                        bool check = false;
                        for (int i = 0; i < users.length; i++) {
                          print("userid " +
                              users[i].userid +
                              " == " +
                              textControl[0].text);
                          print("pass " +
                              users[i].password +
                              " == " +
                              textControl[1].text);

                          if (users[i].userid == textControl[0].text &&
                              users[i].password == textControl[1].text) {
                            check = true;
                            SharePreference.id = users[i].id;
                            SharePreference.setAttr(users[i]);
                            Navigator.pushReplacementNamed(context, "/Main");
                          }
                        }
                        if (!check) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid user or password"),
                        ));
                          // Fluttertoast.showToast(
                          //     msg: "Invalid user or password",
                          //     toastLength: Toast.LENGTH_SHORT);
                        }
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: GestureDetector(
                        child: Text("Register New Account",
                            style: TextStyle(color: Colors.green),
                            textDirection: TextDirection.ltr),
                        onTap: () {
                          Navigator.pushNamed(context, "/regist");
                        },
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 15, 0),
                    ))
              ],
            ),
          );
        }));
  }
}
