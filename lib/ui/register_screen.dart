import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/user_model.dart';
import '../db/db.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:validators/validators.dart';
class RegisterScreen extends StatefulWidget {
  @override
  MyRegist createState() {
    return MyRegist();
  }
}

class MyRegist extends State<RegisterScreen> {
  List<TextEditingController> textControl = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
              title: Text("REGISTER"),
        ),
        body: Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "User Id",
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.text,
                    controller: textControl[0],
                    onSaved: (value) => print(value),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "กรุณาระบุ user";
                      }else if(value.length <6 || value.length >12){
                        return "กรุณาระบุความยาว user id ให้ถูกต้อง";
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                    Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person_pin),
                    ),
                    keyboardType: TextInputType.text,
                    controller: textControl[1],
                    onSaved: (value) => print(value),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "กรุณาระบุชื่อ";
                      } else{
                        int count =0;
                        for(int i=0;i<value.length;i++){
                          if(value[i] ==" "){
                            count++;
                          }
                        }
                        print(count);
                        if(count >1 || count ==0)
                        return "กรุณาระบุนามสกุลให้ถูกต้อง";
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                 Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Age",
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: textControl[2],
                    onSaved: (value) => print(value),
                    validator: (value) {
                      print(isInt(value));
                      try{
                        int age = int.parse(value);
                        if((age > 80 || age <10)){
                         return "กรุณาระบุอายุให้ถูกต้อง";
                      }
                      }
                      catch (e){
                        return "กรุณาระบุอายุเป็นตัวเลข";
                      }
                      if (value.isEmpty) {
                        return "กรุณาระบุอายุ";

                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    controller: textControl[3],
                    onSaved: (value) => print(value),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "กรุณาระบุ password";
                      }else if(value.length<6){
                        return "ความยาว password ไม่เพียงพอ";
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                Container(
                  child: RaisedButton(
                    child:
                        Text("REGISTER NEW ACCOUNT"),
                    color: Theme.of(context).accentColor,
                    onPressed: () async{
                      if (!_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("กรุณาระบุข้อมูลให้ครบถ้วน"),
                        ));
                      }  else {
                        User user = new User(userid: textControl[0].text, name: textControl[1].text, age: int.parse(textControl[2].text),
                        password: textControl[3].text
                        );
                        print(user.name);
                        await DBProvider.db.newUser(user);
                       
                        // Fluttertoast.showToast(msg:"User "+user.name+ " was saved", toastLength:Toast.LENGTH_SHORT);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                )
              ],
            ),
          );
        }));
  }
}
