// flutter/material.dart: This is the core Flutter package for creating UIs with pre-designed widgets.
import 'package:flutter/material.dart';

/// myclasstwo/constants/colors.dart: This file likely contains custom colors defined for the app.
import 'package:myclasstwo/constants/colors.dart';


/// myclasstwo/models/todo.dart: This is probably where the ToDo class is defined. It represents a single To-Do item.
import 'package:myclasstwo/models/todo.dart';

/// myclasstwo/widgets/todo_items.dart: This file  defines the widget used to display each To-Do item in the list.
import 'package:myclasstwo/widgets/todo_items.dart';

// PROJECT DETAILS, OBJECTIVES/PURPOSE
/// This Flutter code creates a simple "To-Do" app. The app allows users to:
/// View a list of tasks (To-Do items).
/// Mark tasks as done or not done.
/// Delete tasks.
/// Add new tasks.
/// Search for tasks.

/// Home Stateful Widget
/// Home: This is a StatefulWidget, meaning the screen can change based on user actions (like adding or deleting a To-Do).
///  StatefulWidget: It’s used when the UI can change over time (in this case, when To-Do items are added, deleted, or marked as done).
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

/// State Management in _HomeState
/// todosList: This list contains all To-Do items. It’s initialized with some default items from ToDo.todoList().
///  _foundToDo: This is a filtered list of To-Dos based on the search. Initially, it’s empty.
/// _todoController: This controller helps to manage the input from the user when they add a new To-Do item.
class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  /// Handling To-Do Actions
  /// _handleToDoChange: This function toggles a To-Do item between "done" and "not done" by changing the isDone property.
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  ///_deleteToDoItem: This function removes a To-Do item from the list based on its id.
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  ///_addToDoItem: This function adds a new To-Do item to the list with a unique id based on the current time. After adding the item, it clears the input field.
  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  /// Initializing the State
  /// initState: This function is called when the widget is first created. It sets _foundToDo to show all To-Dos initially.
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  /// _runFilter: This function filters the list of To-Dos based on what the user types in the search bar. If the search bar is empty, it shows all To-Dos.
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  /// Building the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      appBar: AppBar(
        backgroundColor: myBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: blackColor,
              size: 30,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/mypicture.jpeg'),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: blackColor,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: greyColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                          fontWeight: FontWeight.w300,
                            color: blackColor,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// TEXTFIELD AT THE BUTTOM
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                /// ELEVATED BUTTON
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// POINTS TO NOTE DOWN
/// Scaffold: Provides a structure for the basic visual layout, including an app bar at the top and a body.
/// AppBar: Contains a menu icon and a profile image.
/// Search Bar - TextField: A search bar at the top allows users to type and filter the list of To-Dos.
/// To-Do List -  ListView: A scrollable list that shows all the To-Dos. The ToDoItem widget is used to display each item.
/// Add To-Do Bar - Bottom TextField: A text input at the bottom lets users type a new To-Do
/// ElevatedButton: A button that, when pressed, adds the new To-Do to the list.

/// IN SUMMARY
/// This app allows users to manage a list of tasks.
/// Users can add, delete, mark tasks as done, and search for tasks.
/// The UI is built using Flutter widgets like Scaffold, AppBar, ListView, TextField, and ElevatedButton
