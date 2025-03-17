import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/provider/task_provider.dart';
import 'package:task_master/utils/save_task.dart';

void showPriorityDialog(BuildContext context, TextEditingController titleController, TextEditingController descriptionController, DateTime? dueDate, TaskPriority? priority, Task? task) {
  TaskPriority? tempPriority = priority;
  showDialog(
    
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(5), left: Radius.circular(10))),
        title: const Center(
          child: Text(
            "Task Priority",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SizedBox(
              width: 372,
              height: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(color: Colors.white, thickness: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildPriorityButton("High", Colors.red, TaskPriority.high, priority, (newPriority) {
                          setDialogState(() {
                            tempPriority = newPriority;
                            priority = newPriority;
                          });
                        }),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildPriorityButton("Medium", Colors.yellow, TaskPriority.medium, priority, (newPriority) {
                          setDialogState(() {
                            tempPriority = newPriority;
                            priority = newPriority;
                          });
                        }),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildPriorityButton("Low", Colors.green, TaskPriority.low, priority, (newPriority) {
                          setDialogState(() {
                            tempPriority = newPriority;
                            priority = newPriority;
                          });
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height:50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    onPressed: () {
                      if (tempPriority != null ) {
                        setDialogState(() {
                          priority = tempPriority;
                        });
                        } 
                        if (dueDate != null) {
                        saveTask(context, titleController, descriptionController, dueDate, priority!, task);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Widget _buildPriorityButton(String text, Color color, TaskPriority taskPriority, TaskPriority? selectedPriority, Function(TaskPriority) onTap) {
  return GestureDetector(
    onTap: () => onTap(taskPriority),
    child: Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selectedPriority == taskPriority ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/flag1.png", height: 24, color: Colors.white),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12), ),
        ],
      ),
    ),
  );
}