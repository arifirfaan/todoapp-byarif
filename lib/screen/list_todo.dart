import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/sql_helper.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/screen/create_list.dart';

class ListTodo extends StatefulWidget {

  /// constructor
  const ListTodo({Key? key}) : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {

  DateTime selectedDate = DateTime.now();
  late String _formattedDate = "";
  // All journals
  List<Map<String, dynamic>> _todoData = [];

  @override
  void initState(){
    super.initState();
    _getList();
  }

  Future<void> _getList() async {
    _todoData = await TodoCrud.refreshJournals();
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
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
      _formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(picked!);
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context){
                  return CreateList(
                    onCallback: (String title, String desc, String date){
                      setState(() {
                        TodoCrud.addItem(title, desc, date);
                      });
                    }
                  ,);
                })
              );
            },
            child: const Icon(Icons.ac_unit_sharp),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _todoData.isEmpty ?
          const Center(
            child: Expanded(
              child: Text(
                "There is no list of todo, you can create a todo list by click the button at top right corner",
                style: TextStyle(fontSize: 20),
              )
            ),
          )
          :
          ListView.builder(
          itemCount: _todoData.length,
          itemBuilder: (BuildContext context, int i){
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(i.toString()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  child: Column(
                    children: [
                      Text(_todoData[i]['title'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      Text(_todoData[i]['description'], style: const TextStyle(fontSize: 15),),
                      Text(_todoData[i]['date'])
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      )
    );
  }
}