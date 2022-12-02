import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tool_app/modal/Task.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseReference db = FirebaseDatabase.instance.ref('/todos');
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<Task> itemsWithParameter(bool value) {
    return UnmodifiableListView(
        _tasks.where((Task item) => item.isCheck == value));
  }


  void addInBdd(Task item) async {
    var newChildRef = db.push();
    item.id = newChildRef.key!;
    newChildRef.set(item.toJson());
    notifyListeners();
  }

  void removeInBdd(String id) async{
    await db.child(id).remove();
    notifyListeners();
  }


  void updateInBdd(Task task) async{
    await db.child(task.id).update(task.toJson());
    notifyListeners();
  }

  changeValue(String id) {}

  }
