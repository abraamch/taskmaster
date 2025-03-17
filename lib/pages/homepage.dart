import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/provider/task_provider.dart';
import 'package:task_master/widgets/task_form.dart';
import 'package:task_master/widgets/appbar.dart';
import 'package:task_master/widgets/priority_filter.dart';
import 'package:task_master/widgets/search_bar.dart';
import 'package:task_master/widgets/task_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TaskPriority? selectedPriority;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final allTasks = taskProvider.tasks;

    final filteredTasks = selectedPriority == null
        ? allTasks
        : taskProvider.getTasksByPriority(selectedPriority!);

    
    final pendingTasks = filteredTasks.where((task) => !task.isDone).toList();
    final completedTasks = filteredTasks.where((task) => task.isDone).toList();

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Scaffold(
          appBar: MyAppBar(),
          //  if the lists of tasks are empty
          body: taskProvider.isEmpty()
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Checklist-rafiki 1.png'),
                      Text(
                        'What do you want to do today?',
                        style: TextStyle(fontSize: 20, fontFamily: 'Lato', color: Color(0xFFDEFFFFFF)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Get started by adding a new task',
                        style: TextStyle(fontSize: 16, fontFamily: 'Lato', color: Color(0xFFDEFFFFFF)),
                      ),
                    ],
                  ),
                )
                // else show the search bar and tasks 
              : Column(
                  children: [
                    GestureDetector(
                      child: MySearchBar(),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => PrioritySelector(
                            selectedPriority: selectedPriority,
                            onPrioritySelected: (priority) {
                              setState(() => selectedPriority = priority);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: pendingTasks.length + (completedTasks.isNotEmpty ? completedTasks.length + 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < pendingTasks.length) {
                            return Align(
                              alignment: Alignment.center,
                              child: TaskTile(task: pendingTasks[index]));
                          } else if (index == pendingTasks.length && completedTasks.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IntrinsicWidth(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 84, 81, 81),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: TaskTile(task: completedTasks[index - pendingTasks.length - 1]));
                          }
                        },
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Color(0xFF363636),
                context: context,
                isScrollControlled: true,
                builder: (context) => TaskForm(),
              );
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
    ) );
    
  }
}

