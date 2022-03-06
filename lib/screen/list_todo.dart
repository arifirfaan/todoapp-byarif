import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutorialf/model/todo.dart';

class ListTodo extends StatefulWidget {


  ListTodo({Key key}) : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {

  List<Todo> _todoList = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _formattedDate = "";

  @override
  void initState(){
    super.initState();
  }

  void _onDialogCreateTodo(BuildContext context){
    showDialog(context: context, builder: (BuildContext ctx){
      return AlertDialog(
        title: Text("Create Todo"),
        content: Column(
          children: [
            Text("Title :"),
            TextField(
              controller: _titleController,
            ),
            Text("Content"),
            TextField(
              controller: _contentController,
            ),
            InkWell(
              onTap: (){
                _selectDate(context);
              },
              child: Text("Select Date"),
            ),
            Text(_formattedDate)
          ],
        ),
        actions: [
          ElevatedButton(onPressed: (){
            setState(() {
              _todoList.add(
                Todo(
                  id: "01",
                  title: _titleController.text,
                  content: _contentController.text,
                  date: selectedDate
                )
              );
            });
            Navigator.pop(context);
          }, child: Text("Save"))
        ],
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //   });
    setState(() {
      _formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(picked);
      selectedDate = picked;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              _onDialogCreateTodo(context);
            },
            child: Icon(Icons.create)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: _todoList.isEmpty ?
          Center(
            child: Expanded(
              child: Text(
                "There is no list of todo, you can create a todo list by click the button at top right corner",
                style: TextStyle(fontSize: 20),
              )
            ),
          )
          :
          ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int i){
            return Text(_todoList[i].title);
          }
        ),
      )
    );
  }
}