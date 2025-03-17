import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskPriority { low, medium, high }

class Task {
  String id;
  String title;
  String description;
  TaskPriority priority;
  bool isDone;
  DateTime limitDate;

  Task(void saveTask, {
    String? id,
    required this.title,
    required this.priority,
    required this.description,
    this.isDone = false,
    required this.limitDate,
  }) : id = id ?? UniqueKey().toString();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority.toString().split('.').last,
      'isDone': isDone,
      'limitDate': limitDate.toIso8601String(),
    };
  }

  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      (task) => {},
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      priority: TaskPriority.values.firstWhere(
        (e) => e.toString().split('.').last == data['priority'],
        orElse: () => TaskPriority.low,
      ),
      isDone: data['isDone'] ?? false,
      limitDate: data['limitDate'] != null
          ? DateTime.parse(data['limitDate'])
          : DateTime.now(),
    );
  }

  String? validate() {
    if (title.isEmpty) return "Title is required";
    if (description.isEmpty) return "Description is required";
    if (priority == null) return "Priority is required";
    if (limitDate == null) return "Due date must be in the future";
    return null;
  }
}