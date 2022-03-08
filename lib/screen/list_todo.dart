import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_crud.dart';
import 'package:todoapp/screen/create_list.dart';
import 'package:todoapp/screen/item_detail.dart';

class ListTodo extends StatefulWidget {

  /// constructor
  const ListTodo({Key? key}) : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {

  // All Todo list
  List<Map<String, dynamic>> _todoData = [];

  @override
  void initState(){
    super.initState();
    TodoCrud.refreshTodos().then((value){
      setState(() {
        _todoData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/logo_todo.png", fit: BoxFit.fitHeight, height: 30,),
      ),
      body: Container(
        color: Colors.blueGrey[200],
        margin: const EdgeInsets.all(20),
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () async {
                    _todoData = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context){
                        return ItemDetail(item: Todo(id: _todoData[i]['id'], title: _todoData[i]['title'], description: _todoData[i]['description'], date:  _todoData[i]['date']));
                      })
                    );
                    setState(() {});
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((i+1).toString(), style: const TextStyle(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_todoData[i]['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(_todoData[i]['description'], style: const TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            Text(_todoData[i]['date'], style: const TextStyle(fontSize: 15),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () async {
          _todoData = await Navigator.push(
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
          setState(() {});
        },
        child: const Icon(Icons.create_outlined),
      ),
    );
  }
}