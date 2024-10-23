// flutter/material.dart: This package contains Flutter's material design components, like Container, ListTile, Icon, etc.
import 'package:flutter/material.dart';

// myclasstwo/constants/colors.dart: It imports predefined colors (like blueColor, blackColor, redColor).
import 'package:myclasstwo/constants/colors.dart';

// myclasstwo/models/todo.dart: This imports a model class ToDo, which defines the structure for a to-do item, like its text and status (completed or not).
import 'package:myclasstwo/models/todo.dart';

/// The ToDoItem Class
/// ToDoItem is a stateless widget. It represents a single to-do item and doesn’t manage any state on its own.
class ToDoItem extends StatelessWidget {
  /// final ToDo todo;: This is the ToDo object passed to the widget. It contains data like the to-do text and its completion status (whether it's done or not).
  final ToDo todo;

  /// final onToDoChanged;: A callback function to handle when the to-do item's state changes (e.g., when it’s marked as completed or not).
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;

  /// final onDeleteItem;: A callback function to handle when the to-do item is deleted
  /// ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;

  /// Constructor
  /// This is the constructor for the widget. It accepts the todo (required), onToDoChanged, and onDeleteItem callbacks as parameters. These are passed in when creating the ToDoItem widget
  const ToDoItem(
      {super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});

// The Build Method
  @override

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),

      /// build(): This method returns the widget structure.
      ///  Container: A wrapper widget that gives padding, margins, and background color.
      /// ListTile: A material design widget that displays a single row of text with a leading icon, title, and trailing widget
      child: ListTile(
        /// onTap:: This is the action triggered when you tap the entire ListTile. It calls the onToDoChanged callback, passing the current todo object to handle when the user interacts with the to-do item
        onTap: () {
          onToDoChanged(todo);
        },

        // ListTile Customization
        /// shape:: Gives the tile rounded corners with a radius of 20.
        /// contentPadding:: Adds padding inside the tile
        /// tileColor:: Sets the background color of the tile to white
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,

        /// Leading Icon
        /// leading:: This defines the icon shown on the left side of the ListTile.
        /// oIf the to-do item is done (todo.isDone is true), it shows a checked checkbox (Icons.check_box).
        /// Otherwise, it shows an empty checkbox (Icons.check_box_outline_blank).
        /// The icon color is set to blueColor.
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: blueColor),
            
        // Title
        /// title:: The main text inside the ListTile, which shows the todo.todoText
        /// The text is styled with a font size of 19 and black color.
        /// If the to-do item is completed (todo.isDone is true), it adds a line-through decoration to show that the item is crossed off.
        title: Text(
          todo.todoText,
          style: TextStyle(
            fontSize: 19,
            color: blackColor,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),

        /// Trailing Delete Button
        /// trailing:: This defines a custom widget on the right side of the ListTile. It contains a delete button.
        /// Container: It wraps the IconButton and gives it a red background (redColor), a fixed height/width, and rounded corners.
        /// IconButton: Displays a delete icon (Icons.delete). When the button is pressed, it calls the onDeleteItem callback, passing the todo.id, which will trigger the delete functionality for this to-do item.
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: redColor, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            onPressed: () {
              /// print(Clicked on Delete Icon);
              onDeleteItem(todo.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}

///The Summary of all the Functionality
/// The ToDoItem widget displays a to-do with a checkbox (leading icon), its text (title), and a delete button (trailing).
/// When the to-do item is tapped, it calls the onToDoChanged callback to mark the item as completed or not.
/// When the delete icon is pressed, it calls the onDeleteItem callback to delete the to-do item.
/// This code defines a simple **`ToDo`** class, which represents a to-do item in a list of tasks. Here's an explanation, step by step:

/// 1. Class Declaration**:
///  - `class ToDo` declares a new class named `ToDo`. A class is a blueprint for creating objects. In this case, each `ToDo` object will represent a single task in your to-do list.

/// 2. Attributes**:
/// - `String? id`: This is an optional (nullable) string that represents a unique identifier for each to-do item. The `?` means that the `id` can either hold a value (like '01') or be null (no value assigned).
/// - `String todoText`: This is a string that holds the description of the to-do item (e.g., 'Buy Groceries', 'Morning Exercise').
///  - `bool isDone`: This is a boolean (true/false) that represents whether the task is completed or not. It is `false` by default, meaning tasks are not done unless marked as such.

/// 3. Constructor**:
 ///  - The constructor `ToDo()` allows you to create a new `ToDo` object with specific values. 
/// - `required this.id` and `required this.todoText` ensure that `id` and `todoText` must be provided when creating a `ToDo` object.
///  - **`this.isDone = false` assigns a default value of `false` to `isDone`, meaning a task is not done unless specified otherwise.

/// 4. Static Method**:
/// - `static List<ToDo> todoList()`is a static method that returns a list of pre-defined `ToDo` objects. 
///  - Inside the method, a list is created with several `ToDo` objects, each with its own `id`, `todoText`, and `isDone` status.

/// 5. List of To-Do Items**:
///   - The `todoList()` method creates and returns a list of tasks like:
///  - `Morning Exercise` (completed)
///    - `Buy Groceries` (completed)
///    - `Check Emails` (not completed)
///    - and so on.

/// In summary:
/// - The class defines a structure for a to-do item with an ID, a text description, and a status (done or not done).
/// - It includes a method (`todoList`) that creates a sample list of to-do items with various tasks.





