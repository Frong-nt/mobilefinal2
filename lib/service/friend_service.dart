import 'package:http/http.dart' as http;
import 'package:mobilefinal2/model/todo_model.dart';
import 'dart:async';
import 'dart:io';
import '../model/friend_model.dart';

String url = "https://jsonplaceholder.typicode.com/users";

Future<List<Friend>> getAllFriend() async {
  url = "https://jsonplaceholder.typicode.com/users";
  final response = await http.get(url);
  print(response.body);
  return allFriendFromJson(response.body);
}

Future<List<Todo>> getAllTodo(int id) async {
  url = "https://jsonplaceholder.typicode.com/todos?userId=$id";
  final response = await http.get('$url');
  print(response.body);
  return allTodoFromJson(response.body);
}


Future<http.Response> createFriend(Friend post) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: friendToJson(post)
  );
  return response;
}
