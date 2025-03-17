import 'package:flutter/material.dart';
import 'package:task_master/models/task.dart';
  
  Color getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
      return Colors.red;
      case TaskPriority.medium:
      return Colors.yellow;
      case TaskPriority.low:
      return Colors.green;
    }
  }