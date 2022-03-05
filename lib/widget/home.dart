import 'package:flutter/material.dart';
import 'package:tutorialf/screen/list_todo.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Guide", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text("1. Click on + icon to add the todo list"),
          Text("2. Type in what ever you want to make and click on save button"),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context){
                  return ListTodo();
                })
              );
            },
            child: Text("Continue")
          )
        ]
      ),
    );
  }
}