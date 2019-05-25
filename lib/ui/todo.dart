import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/todo_model.dart';
import 'package:mobilefinal2/service/friend_service.dart';
// import 'package:mobilefinal2/ui/friend.dart';

class TodoScreen extends StatelessWidget {
  final id;
  final String name;
  TodoScreen({this.id, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("TODO"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: getAllTodo(id),
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
                        Navigator.pushReplacementNamed(context, "/friend");
                      },
                    ),
                  ),
                  Expanded(
                    child: getTodo(snapshot),
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

  ListView getTodo(AsyncSnapshot<List<Todo>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Todo todo = snapshot.data[index];
        return Card(
          child: Container(
            child: RaisedButton(
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(todo.id.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                  Align(
                      alignment: Alignment.centerLeft, child: Text(todo.title)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(todo.completed ? "Completed" : '')),
                ],
              ),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
