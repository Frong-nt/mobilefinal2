import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/friend_model.dart';
import 'package:mobilefinal2/service/friend_service.dart';
import 'package:mobilefinal2/ui/todo.dart';

class FriendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FRIEND"),
      ),
      body: FutureBuilder<List<Friend>>(
        future: getAllFriend(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Column(
                children: <Widget>[
                  ButtonTheme(
                    buttonColor: Colors.white,
                    minWidth: 350,
                    child: RaisedButton(
                      child: Text("Back",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, "/Main");
                      },
                    ),
                  ),
                  Expanded(
                    child: getFriends(snapshot),
                  ),
                ],
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListView getFriends(AsyncSnapshot<List<Friend>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Friend friend = snapshot.data[index];
        return Card(
          child: Container(
            child: RaisedButton(
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(friend.id.toString() + " : " + friend.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(friend.email)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(friend.phone)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(friend.website),
                  )
                ],
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoScreen(
                            id: friend.id,
                            name: friend.name,
                          )),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
