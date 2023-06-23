import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodo/constants/colors.dart';
import 'package:mytodo/model/todo.dart';
import 'package:mytodo/widgets/appBar.dart';
import 'package:mytodo/widgets/searchBox.dart';
import 'package:mytodo/widgets/todoItems.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final todoLists = Todo.todoList();
  List<Todo> _foundtodo = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundtodo = todoLists;
    super.initState();
  }

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
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            'All Todos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (Todo todo in _foundtodo.reversed)
                          TodoItems(
                            todo: todo,
                            onTodoChange: handleTodoChange,
                            onTodoDelete: deleteTodoItem,
                          )
                      ],
                    ),
                  )
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
                        controller: _todoController,
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
                          onPressed: () {
                            _addTodoItem(_todoController.text);
                          },
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

  void handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void deleteTodoItem(String id) {
    setState(() {
      todoLists.removeWhere((element) => element.id == id);
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todoLists.add(Todo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: todo,
          isDone: false));
    });
    _todoController.clear();
  }

  void _runfilter(String EnteredKey) {
    List<Todo> result = [];
    if (EnteredKey.isEmpty) {
      result = todoLists;
    } else {
      result = todoLists
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(EnteredKey.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundtodo = result;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
