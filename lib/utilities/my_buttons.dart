import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MyButtons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 189, 58),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0, // Spread radius
            blurRadius: 0.5, // Blur radius
            offset: const Offset(1, 2), // Shadow offset (x, y)
          ),
        ],
        
   
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 253, 242, 186), // Set text color
            fontSize: 16, // Adjust text size if needed
          ),
        ),
      ),
    );
  }
}
