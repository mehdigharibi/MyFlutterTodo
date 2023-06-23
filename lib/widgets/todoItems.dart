import 'package:flutter/material.dart';
import 'package:mytodo/model/todo.dart';
import '../constants/colors.dart';

class TodoItems extends StatelessWidget {
  final Todo todo;
  final onTodoChange;
  final onTodoDelete;
  const TodoItems(
      {Key? key,
      required this.todo,
      required this.onTodoChange,
      required this.onTodoDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          (todo.isDone!)
              ? Icons.check_box
              : Icons.check_box_outline_blank_outlined,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: (todo.isDone!)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
            ),
            iconSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
