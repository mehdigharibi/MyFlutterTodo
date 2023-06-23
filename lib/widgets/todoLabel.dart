import 'package:flutter/material.dart';
import 'package:mytodo/model/todo.dart';
import 'package:mytodo/widgets/todoItems.dart';

Widget todoLabel() {
  final todoLists = Todo.todoList();

  return Expanded(
    child: ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50, bottom: 20),
          child: Text(
            'All Todos',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        for (Todo todo in todoLists) TodoItems(todo: todo)
      ],
    ),
  );
}
