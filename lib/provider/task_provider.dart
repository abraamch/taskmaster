import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Task> tasks = [];


  TaskProvider() {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final snapshot = await _firestore.collection('tasks').get();
      tasks = snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  Future<void> addTask(Task task) async {
    final validationMessage = task.validate();
    if (validationMessage != null) {
      throw Exception(validationMessage);
    }

    try {
      final docRef = await _firestore.collection('tasks').add(task.toMap());
      task.id = docRef.id;
      tasks.add(task);
      notifyListeners();
    } catch (e) {
      print("Error adding task: $e");
    }
  }

    Future<void> updateTask(Task updatedTask) async {
    final validationMessage = updatedTask.validate();
    if (validationMessage != null) {
      throw Exception(validationMessage);
    }

    try {
      await _firestore.collection('tasks').doc(updatedTask.id).update(updatedTask.toMap());
      final index = tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating task: $e");
    }
  }

  Future<void> removeTask(Task task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).delete();
      tasks.removeWhere((t) => t.id == task.id);
      notifyListeners();
    } catch (e) {
      print("Error removing task: $e");
    }
  }

  Future<void> toggleTask(Task task) async {
    try {
      task.isDone = !task.isDone;
      await _firestore.collection('tasks').doc(task.id).update({'isDone': task.isDone});
      notifyListeners();
    } catch (e) {
      print("Error toggling task: $e");
    }
  }

  List<Task> getTasks() => tasks;

  List<Task> getTasksByPriority(TaskPriority priority) {
    return tasks.where((task) => task.priority == priority).toList();
  }

  bool isEmpty() => tasks.isEmpty;
}
