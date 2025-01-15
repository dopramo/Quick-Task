import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uui2/data/database.dart';
import 'package:uui2/utilities/dialog_box.dart';
import 'package:uui2/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  late Box _myBox;
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  // Initialize Hive and open the box
  Future<void> _initializeHive() async {
    _myBox = await Hive.openBox('mybox');
    // If it's the first time the app is opened, create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitiaData();
    } else {
      // Otherwise, load existing data
      db.loadData();
    }
    setState(() {});
  }

  //text controller
  final _controller = TextEditingController();

  //check was tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        db.toDoList.add([_controller.text.trim(), false]); // Trim any extra spaces
        _controller.clear(); // Clear the input field
      });
      Navigator.of(context).pop(); // Close the dialog
    } else {
      // Optionally, show an error message for empty input
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task cannot be empty!")),
      );
    }
    db.updateDataBase();
  }

  //create new task
  void createNewTask() {
    // Clear the controller to ensure the text field is empty when the dialog opens
    _controller.clear();

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear(); // Optionally clear again if the user cancels
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);  // Use removeAt(index) instead of remove(index)
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 236, 162),
      appBar: AppBar(
  title: Text(
    "Q U I C K   T A S K",
    style: TextStyle(
      fontWeight: FontWeight.bold,  // Makes the text bold
      fontSize: 24,  // Sets the font size
    ),
  ),
  centerTitle: true,
  backgroundColor: const Color.fromARGB(255, 255, 189, 58),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
  elevation: 0,
),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 255, 189, 58),
        foregroundColor: Color.fromARGB(255, 250, 236, 162),
        elevation: 5,
        
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),  // Pass index here
          );
        },
      ),
    );
  }
}
