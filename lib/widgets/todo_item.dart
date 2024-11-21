import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/app_provider.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;

  ToDoItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    return CheckboxListTile(
      title: Text(todo.title),
      subtitle: Text("Priority: ${todo.priority}"),
      value: todo.isCompleted,
      onChanged: (value) {
        provider.toggleToDoStatus(todo);
      },
    );
  }
}
