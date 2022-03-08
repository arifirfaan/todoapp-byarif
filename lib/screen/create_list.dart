import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoapp/model/meeting_model.dart';
import 'package:todoapp/model/todo_crud.dart';



/// page for create a new todo
// ignore: must_be_immutable
class CreateList extends StatefulWidget {

  /// callback function to triggere create todo
  Function(String, String, String) onCallback;

  CreateList({required this.onCallback, Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {

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

  /// Show dialog box if user not type any title and description
  void _showWarning(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Warning!"),
        content: const Text("You're not type in the title and description. Please don't leave it empty."),
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Ok")
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2))
                ),
              ),
            ),
            const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2))
                ),
              ),
            ),
            const Text("Select Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SfCalendar(
              view: CalendarView.month,
              dataSource: EventDataSource(_getDataSource()),
              onSelectionChanged: (CalendarSelectionDetails details){
                _getDataSource(date: details.date);
                _getDate(details.date!);
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  if(_titleController.text.isEmpty && _descController.text.isEmpty){
                    _showWarning();
                  } else {
                    if(_dateString == ""){
                      _getDate(_getDataSource()[0].from);
                    }
                    widget.onCallback(_titleController.text, _descController.text, _dateString);
                    _todoData = await TodoCrud.refreshTodos();
                    Navigator.pop(context, _todoData);
                  }
                },
                child: const Text("Create")
              ),
            )
          ],
        ),
      ),
    );
  }
}