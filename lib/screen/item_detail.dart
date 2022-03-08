import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoapp/model/meeting_model.dart';
import 'package:todoapp/model/todo_crud.dart';

class ItemDetail extends StatefulWidget {
  /// Class of Todo
  final Todo item;

  /// constructor
  const ItemDetail({
    required this.item,
    Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  /// flag to indicate edit status
  late bool _isEdit = false;
  /// Text controller for title
  final TextEditingController _titleController = TextEditingController();
  /// Text controller for description
  final TextEditingController _descController = TextEditingController();
  /// list of todos
  List<Map<String, dynamic>> _todoData = [];
  /// Date shown as string
  late String _dateString = "";

  @override
  void initState(){
    _titleController.text = widget.item.title;
    _descController.text = widget.item.description;
    super.initState();
  }

  /// function to get time to show in calendar
  List<Event> _getDataSource({DateTime? date}) {
    final List<Event> meetings = <Event>[];
    final DateTime today = DateTime.now();
    DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    if(date != null){
      startTime = DateTime(date.year, date.month, date.day, 9, 0, 0);
    }
    meetings.add(
      Event(
        _titleController.text, startTime, startTime, const Color(0xFF0F8644), false)
      );
    return meetings;
  }

  /// function to process selected to store in database
  void _getDate(DateTime date){
    setState(() {
      _dateString = DateFormat('dd-MM-yyyy – kk:mm').format(date);
    });
  }

  /// Show dialog box if user confirm delete
  void _showConfirm(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Warning!"),
        content: const Text("Are you confirm to delete?"),
        actions: [
          ElevatedButton(
            onPressed: (){
              TodoCrud.deleteItem(widget.item.id!, widget.item, context);
              Navigator.pop(context);
              Navigator.pop(context, _todoData);
            },
            child: const Text("Yes")
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No")
          )
        ],
      );
    });
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
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/logo_todo.png", fit: BoxFit.fitHeight, height: 30,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("Title", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: _isEdit ?
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: widget.item.title,
                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2))
                ),
              )
              : Text(widget.item.title, style: const TextStyle(fontSize: 20)),
            ),
            const Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: _isEdit ?
                TextField(
                  controller: _descController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: widget.item.description,
                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2))
                  ),
                )
                : Expanded(child: Text(widget.item.description, style: const TextStyle(fontSize: 20))),
            ),
            const Text("Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: _isEdit ?
                SfCalendar(
                  view: CalendarView.month,
                  dataSource: EventDataSource(_getDataSource()),
                  onSelectionChanged: (CalendarSelectionDetails details){
                    _getDataSource(date: details.date);
                    _getDate(details.date!);
                  },
                )
              : Text(widget.item.date, style: const TextStyle(fontSize: 20)),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: (){
                _showConfirm();
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text("Delete")
            ),
            ElevatedButton.icon(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: (){
                setState(() {
                  if(_isEdit == true){
                    _isEdit = false;
                  } else {
                    _isEdit = true;
                  }
                });
              },
              icon: const Icon(Icons.edit_attributes),
              label: Text( _isEdit ? "Cancel Edit" : "Edit")
            ),
            _isEdit ?
            ElevatedButton.icon(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () async {
                if(_dateString == ""){
                  _getDate(_getDataSource()[0].from);
                }
                TodoCrud.updateItem(
                  widget.item.id!,
                  Todo(description: _descController.text, title: _titleController.text, date: _dateString)
                );
                _todoData = await TodoCrud.refreshTodos();
                Navigator.pop(context, _todoData);
              },
              icon: const Icon(Icons.update_rounded),
              label: const Text("Update")
            ) : Container()
          ],
        ),
      ),
    );
  }
}