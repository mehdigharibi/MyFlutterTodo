import 'package:flutter/material.dart';
import 'package:mytodo/widgets/todoItems.dart';

Widget todoLabel() {
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
        todoItems(),
        todoItems(),
        todoItems(),
        todoItems(),
        todoItems(),
      ],
    ),
  );
}
