import 'package:flutter/material.dart';
import 'package:todoapp/screen/list_todo.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text("Guide", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("1. Click on the icon at bottom right corner to add the todo list."),
          )),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("2. Type in what ever you want to make and click on create button."),
          )),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("3. You can click on row the of the list to view the detail of todo."),
          )),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("4. In the detail page you can edit and delete the detail."),
          )),
          const SizedBox(height: 50,),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context){
                  return const ListTodo();
                })
              );
            },
            child: const Text("Continue")
          )
        ]
      ),
    );
  }
}