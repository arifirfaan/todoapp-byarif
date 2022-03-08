
import 'package:flutter/material.dart';
import 'package:todoapp/model/sql_helper.dart';

class Todo{

  final int? id;
  final String title;
  final String description;
  final String date;

  Todo({this.id, required this.description, required this.title, required this.date});
}

 class TodoCrud{

  TodoCrud._();
  // This function is used to fetch all data from the database
  static Future<List<Map<String, dynamic>>> refreshTodos() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getItems();
    return data;
  }


// Insert a new todo to the database
  static Future<void> addItem(String title, String desc, String date) async {
    await SQLHelper.createItem(
    title, desc, date);
    refreshTodos();
  }

  // Update an existing todo
  static Future<void> updateItem(int id, Todo data) async {
    await SQLHelper.updateItem(
      id,data.title, data.description, data.date);
    refreshTodos();
  }

  // Delete an item
  static void deleteItem(int id, Todo data, BuildContext context) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a todo!'),
    ));
    refreshTodos();
  }

}