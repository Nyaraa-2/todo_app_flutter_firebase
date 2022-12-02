import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_app/modal/Task.dart';
import 'package:tool_app/provider/TaskProvider.dart';
import 'package:tool_app/screen/Dialog/SingleDialog.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    Key? key,
    required this.isCheck,
  }) : super(key: key);
  final bool isCheck;

  List<Task> dataToTask(DataSnapshot? dataSnapshot) {
    List<Task> tasks = [];
    if (dataSnapshot != null) {
      for (DataSnapshot data in dataSnapshot.children) {
        Task task = Task(
            id: data.child("todo_id").value.toString(),
            text: data.child("todo_name").value.toString(),
            isCheck: data.child("todo_done").value as bool
        );
        tasks.add(task);
      }
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        DatabaseReference reference = FirebaseDatabase.instance.ref('/todos');
        return Scaffold(
          body: FutureBuilder(
            future: reference.get(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Task> items = provider.itemsWithParameter(isCheck);

                List<Task> tasks = dataToTask(snapshot.data).where((Task item) => item.isCheck == isCheck).toList();
                return Container(
                  child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Task current = tasks[index];
                        return ListTile(
                          title: Text(current.text),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              print(current.id);
                              Provider.of<TaskProvider>(context, listen: false)
                                  .removeInBdd(current.id);
                            },
                          ),
                        );
                      }),
                );
              } else {
                throw Error();
              }
            },
          ),
        );
      },
    );
  }

  void deleteTask(BuildContext context, Task item) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title: "Voulez vous supprimer la tache ${item.id.substring(0, 8)}",
          content: Text(item.text),
          textOKButton: "Conserver",
          textCancelButton: "Supprimer",
          callbackOK: () {},
          callbackCancel: () =>
              Provider.of<TaskProvider>(context, listen: false)
                  .removeInBdd(item.id),
        );
      },
    );
  }

  void updateTask(BuildContext context, Task item) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title:
              "Confirmer votre choix pour la tache ${item.id.substring(0, 8)}",
          content: Text(item.text),
          textOKButton: "Valider",
          textCancelButton: "Annuler",
          callbackOK: () => Provider.of<TaskProvider>(context, listen: false)
              .changeValue(item.id),
          callbackCancel: () {},
        );
      },
    );
  }
}
