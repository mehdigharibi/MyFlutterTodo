import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodo/constants/colors.dart';
import 'package:mytodo/helper/sqlHelper.dart';
import 'package:mytodo/model/todo.dart';
import 'package:mytodo/widgets/appBar.dart';

import 'package:mytodo/widgets/todoItems.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  final todoLists = Todo.todoList();
  List<Todo> _foundtodo = [];
  final _todoController = TextEditingController();

  void refreshItems() async {
    final data = await SQLHelper.getItems().then((value) {
      setState(() {
        print(value);
        _foundtodo.clear();
        items = value;
        items.forEach((element) {
          _foundtodo.add(Todo(
              id: element['id'].toString(),
              todoText: element['todotext'].toString(),
              isDone: element['isdone'].toString() == '1' ? true : false));
        });
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    refreshItems();

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
                          ),
                        SizedBox(
                          height: 60,
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

  Future handleTodoChange(Todo todo) async {
    setState(() {
      todo.isDone = !todo.isDone!;
    });

    await SQLHelper.updateItem(todo).then((value) {
      refreshItems();
    });
  }

  Future deleteTodoItem(String id) async {
    await SQLHelper.deleteItem(int.parse(id));

    setState(() {
      refreshItems();
    });
  }

  Future<void> _addTodoItem(String todo) async {
    Todo mytodo = Todo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: todo,
        isDone: false);
    //   todoLists.add( Todo(  id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: todo, isDone: false)
    await SQLHelper.createItem(mytodo).then((value) => _todoController.clear());
    setState(() {
      refreshItems();
    });
  }

  void _runfilter(String EnteredKey) {
    List<Todo> result = [];
    List<Todo> temp = [];
    items.forEach((element) {
      temp.add(Todo(
          id: element['id'].toString(),
          todoText: element['todotext'].toString(),
          isDone: element['isdone'].toString() == '1' ? true : false));
    });

    if (EnteredKey.isEmpty) {
      result = temp;
    } else {
      result = temp
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
