import 'package:flutter/material.dart';

class DynamicListView extends StatefulWidget {
  DynamicListView({Key key}) : super(key: key);

  @override
  _DynamicListViewState createState() => _DynamicListViewState();
}

class _DynamicListViewState extends State<DynamicListView> {

  List<String> carList = [
    'Mercedez-Benz','BMW','Proton','Honda','Perodua'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic ListView'),),
      body: ListView.builder(
        itemCount: carList.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.black12,border: Border.all(color:Colors.black),
            ),
            child: Text(carList[index], style: TextStyle(fontSize: 18),)
          );
        }
      ),
    );
  }
}