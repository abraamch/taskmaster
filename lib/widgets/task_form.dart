import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/utils/save_task.dart';
import 'package:task_master/widgets/show_priority_dialog.dart';

class TaskForm extends StatefulWidget {
  final Task? task;
  const TaskForm({super.key, this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? dueDate;
  TaskPriority? priority;
  bool showDescription = false;
 late FocusNode _titleFocusNode;
 late FocusNode _descriptionFocusNode;
 
  @override
  void initState() {
    super.initState();
    
      if (widget.task != null) {
        showDescription = true;
      } else {WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    }); }
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    dueDate = widget.task?.limitDate;
    priority = widget.task?.priority;
     _titleFocusNode = FocusNode(); 
    _descriptionFocusNode = FocusNode();

     
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                widget.task != null ? "Edit Task" : "Add Task",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                focusNode: _titleFocusNode, 
                style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Lato"),
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter task title",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (showDescription) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  focusNode: _descriptionFocusNode,
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Lato"),
                  decoration: InputDecoration(
                    hintText: "Enter task description",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_descriptionController.text.isNotEmpty)
                      Row(
                        children: [
                          IconButton(
                            icon: ImageIcon(AssetImage("assets/timer.png"), color: Colors.white),
                            onPressed: _showMyDatePicker,
                          ),
                          IconButton(
                            icon: ImageIcon(AssetImage("assets/tag.png"), color: Colors.white),
                            onPressed: () => saveTask(context, _titleController, _descriptionController, dueDate!, priority!, widget.task),
                          ),
                          IconButton(
                            icon: ImageIcon(AssetImage("assets/flag1.png"), color: Colors.white),
                            onPressed: () => showPriorityDialog(context, _titleController, _descriptionController, dueDate, priority, widget.task),
                          ),
                        ],
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        if (!showDescription) {
                          if (_titleController.text.isNotEmpty) {
                            setState(() => showDescription = true);
                            FocusScope.of(context).unfocus();
                            _descriptionFocusNode.requestFocus();
                          
                          }
                
                        } else if (_descriptionController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          setState(() {});
                          _showMyDatePicker();
                        }
        
                      },
                      icon: Image.asset("assets/Vector.png", width: 20, height: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMyDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      helpText: "Choose expiration date",
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() => dueDate = pickedDate);
      showPriorityDialog(context, _titleController, _descriptionController, dueDate, priority, widget.task);
    }
  }
}