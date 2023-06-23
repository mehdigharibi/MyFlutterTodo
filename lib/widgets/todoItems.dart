import 'package:flutter/material.dart';
import '../constants/colors.dart';

class todoItems extends StatefulWidget {
  const todoItems({super.key});

  @override
  State<todoItems> createState() => _todoItemsState();
}

class _todoItemsState extends State<todoItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print('Click List Tile');
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          Icons.check_box,
          color: tdBlue,
        ),
        title: Text(
          'Check Mail',
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: TextDecoration.lineThrough),
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
