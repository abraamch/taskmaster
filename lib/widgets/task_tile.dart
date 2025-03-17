import 'package:flutter/material.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/utils/getPriority.dart';
import 'package:task_master/provider/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_master/widgets/task_form.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await _deleteConfirmationDialog(context, taskProvider, task);
      },
      child: Padding(
  padding: const EdgeInsets.symmetric(vertical: 6),
  child: SizedBox(
    height: 80, 
    child: Card(
      color: const Color(0xFF363636),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: IconButton(
          icon: Icon(
            task.isDone ? Icons.circle : Icons.radio_button_unchecked,
            color: Colors.white,
          ),
          onPressed: () {
            taskProvider.toggleTask(task);
          },
        ),
        title: Text(
          task.title,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Lato"),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${task.limitDate.day.toString().padLeft(2, '0')}/"
              "${task.limitDate.month.toString().padLeft(2, '0')}",
              style: const TextStyle(color: Colors.white54, fontSize: 14, fontFamily: "Lato"),
            ),
            Container(
              height: 25,
              width: 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: getPriorityColor(task.priority),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Image.asset("assets/flag.png", width: 20, height: 20),
            ),
          ],
        ),
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Color(0xFF363636),
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return TaskForm(task: task);
            },
          );
        },
      ),
    ),
  ),
),

    );
  }
}

Future<bool?> _deleteConfirmationDialog(
    BuildContext context, TaskProvider taskProvider, Task task) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Task"),
      content: const Text("This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            taskProvider.removeTask(task);
            Navigator.pop(context, true);
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
