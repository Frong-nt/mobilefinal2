// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';


Todo todoFromJson(String str) {
    final jsonData = json.decode(str);
    return Todo.fromJson(jsonData);
}

String todoToJson(Todo data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

List<Todo> allTodoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Todo>.from(jsonData.map((x) => Todo.fromJson(x)));
}

String allTodoToJson(List<Todo> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}


class Todo {
    int userId;
    int id;
    String title;
    bool completed;

    Todo({
        this.userId,
        this.id,
        this.title,
        this.completed,
    });

    factory Todo.fromJson(Map<String, dynamic> json) => new Todo(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}
