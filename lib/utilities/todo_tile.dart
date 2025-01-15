import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteFunction!(context);  // Ensure `deleteFunction` is called with the correct context
              },
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 223, 96),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 135, 133, 108).withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              // Checkbox with a custom size using Transform.scale
              Transform.scale(
                scale: 1.2,  // Adjust the scale value to change the size of the checkbox
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
              ),
              // Task name with a custom text size
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 16,  // Adjust font size for the task name text
                  decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
