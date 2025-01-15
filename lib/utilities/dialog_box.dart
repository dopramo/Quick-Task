import 'package:flutter/material.dart';
import 'package:uui2/utilities/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Set your desired radius
      ),
      content: SizedBox(
        height: 150, // Adjusted height to accommodate all content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Get user input
            TextField(
  controller: controller,
  decoration: InputDecoration(
    hintText: "Add a new task",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15), // Rounded corners
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 200, 182, 104), // Color when the TextField is not focused
        width: 2, // Border width
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 255, 189, 58), // Color when the TextField is focused
        width: 2, // Border width
      ),
    ),
    
  ),
),


            // Buttons -> Save + Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                MyButtons(text: "Save", onPressed: onSave),

                const SizedBox(width: 8),

                // Cancel button
                MyButtons(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
