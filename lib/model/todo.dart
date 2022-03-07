
import 'package:flutter/material.dart';
import 'package:todoapp/model/sql_helper.dart';

class Todo{

  final String id;
  final String title;
  final String content;
  final String date;

  Todo({required this.id, required this.content, required this.title, required this.date});
}

 class TodoCrud{

  TodoCrud._();
  // This function is used to fetch all data from the database
  static Future<List<Map<String, dynamic>>> refreshJournals() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getItems();
    // setState(() {
    //   _todoData = data;
    //   _isLoading = false;
    // });
    return data;
  }


// Insert a new journal to the database
  static Future<void> addItem(String title, String desc, String date) async {
    await SQLHelper.createItem(
    title, desc, date);
    refreshJournals();
  }

  // Update an existing journal
  static Future<void> updateItem(int id, Todo data) async {
    await SQLHelper.updateItem(
        id,data.title, data.content, data.date);
    refreshJournals();
  }

  // Delete an item
  static void deleteItem(int id, Todo data, BuildContext context) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    refreshJournals();
  }

}