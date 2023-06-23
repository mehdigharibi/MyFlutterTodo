import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodo/constants/colors.dart';
import 'package:mytodo/model/todo.dart';
import 'package:mytodo/widgets/appBar.dart';
import 'package:mytodo/widgets/searchBox.dart';
import 'package:mytodo/widgets/todoItems.dart';
import 'package:mytodo/widgets/todoLabel.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: TdBGcolor,
        appBar: buildAppbar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  todoLabel(),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ]),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Add new Todo Item',
                            border: InputBorder.none),
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: tdBlue,
                              minimumSize: Size(60, 60)),
                          onPressed: () {},
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 40),
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
