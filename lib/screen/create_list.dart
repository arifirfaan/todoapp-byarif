import 'package:flutter/material.dart';
import 'package:todoapp/screen/list_todo.dart';

class CreateList extends StatefulWidget {

  Function(String, String, String) onCallback;

  CreateList({required this.onCallback, Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [
            const Text("Title :"),
            TextField(
              controller: _titleController,
            ),
            const Text("Content"),
            TextField(
              controller: _descController,
            ),
            InkWell(
              onTap: (){
              },
              child: const Text("Select Date"),
            ),
            ElevatedButton(
              onPressed: (){
                widget.onCallback(_titleController.text, _descController.text, "");
                Navigator.of(context,rootNavigator: true).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return const ListTodo();
                  }));
              },
              child: const Text("Create")
            )
            //Text(_formattedDate)
          ],
        ),
    );
  }
}