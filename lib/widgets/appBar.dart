import 'package:flutter/material.dart';
import 'package:mytodo/constants/colors.dart';

AppBar buildAppbar() {
  return AppBar(
      elevation: 0,
      backgroundColor: TdBGcolor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(20)),
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('asstes/images/avatar.png'),
            ),
          )
        ],
      ));
}
