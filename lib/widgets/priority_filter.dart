import 'package:flutter/material.dart';
import 'package:task_master/models/task.dart';
import 'package:flutter/material.dart';


class PrioritySelector extends StatefulWidget {
  final TaskPriority? selectedPriority;
  final Function(TaskPriority?) onPrioritySelected;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPrioritySelected,
  });

  @override
  _PrioritySelectorState createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  TaskPriority? _tempPriority;

  @override
  void initState() {
    super.initState();
    _tempPriority = widget.selectedPriority;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Center(
        child: Text(
          "Task Priority",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 327,
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(color: Colors.white, thickness: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildPriorityButton("High", Colors.red, TaskPriority.high),
                  buildPriorityButton("Medium", Colors.yellow, TaskPriority.medium),
                  buildPriorityButton("Low", Colors.green, TaskPriority.low),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  widget.onPrioritySelected(_tempPriority);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Apply",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _tempPriority = null);
                  widget.onPrioritySelected(null);
                  Navigator.of(context).pop();
                },
                child: const Text("Clear Filter"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPriorityButton(String text, Color color, TaskPriority taskPriority) {
    return GestureDetector(
      onTap: () {
        setState(() => _tempPriority = taskPriority);
      },
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _tempPriority == taskPriority ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/flag1.png", height: 24, color: Colors.white),
            const SizedBox(height: 4),
            Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
