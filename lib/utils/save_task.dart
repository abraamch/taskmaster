import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/provider/task_provider.dart';

void saveTask(BuildContext context, TextEditingController titleController, TextEditingController descriptionController, DateTime dueDate, TaskPriority priority, Task? task) async {
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
  final newTask = Task(
  (task) => {},
  id: task?.id,
  title: titleController.text,
  description: descriptionController.text,
  priority: priority,
  limitDate: dueDate,
  isDone: task?.isDone ?? false, 
);


  try {
    if (task == null) {
      await taskProvider.addTask(newTask);
    } else {
      await taskProvider.updateTask(newTask);
    }
    Navigator.pop(context);
  } catch (e) {

  ScaffoldMessenger.of(Navigator.of(context, rootNavigator: true).context).showSnackBar(
  SnackBar(content: Text(e.toString())),);
  }
}
