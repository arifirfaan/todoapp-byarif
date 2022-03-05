import 'package:flutter/material.dart';
import 'package:tutorialf/model/todo.dart';

class ListTodo extends StatefulWidget {
  ListTodo({Key key}) : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {

  List<Todo> _todoList = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int i){
            return Text(_todoList[i].title);
          }
        ),
      )
    );
  }
}