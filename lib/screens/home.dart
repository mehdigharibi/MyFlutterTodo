import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodo/constants/colors.dart';
import 'package:mytodo/widgets/appBar.dart';
import 'package:mytodo/widgets/searchBox.dart';
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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              searchBox(),
              todoLabel(),
            ],
          ),
        ),
      ),
    );
  }
}
