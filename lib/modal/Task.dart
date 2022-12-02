import 'package:uuid/uuid.dart';

class Task {
  String id;
  String text;
  bool isCheck;

  Task({this.id = '',required this.text, this.isCheck = false});

  Task.fromJson(Map<String, dynamic> json)
      : text = json["todo_name"],
        id = json["todo_id"],
        isCheck = json["todo_done"];

  Map<String, dynamic> toJson() => {
    'todo_name': text,
    'todo_id': id,
    'todo_done': isCheck,
  };
}