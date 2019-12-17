import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editTask extends StatefulWidget {
  editTask({this.uuid, this.nik, this.customer_name, this.duedate, this.room, this.index});
  final String uuid;
  final String nik;
  final String customer_name;
  final DateTime duedate;
  final String room;
  final index;

  @override
  _editTaskState createState() => _editTaskState();
}

class _editTaskState extends State<editTask> {

  final FocusNode fn1 = FocusNode();
  final FocusNode fn2 = FocusNode();

  TextEditingController controllerUuid;
  TextEditingController controllerNik;
  TextEditingController controllerCustomerName;
  TextEditingController controllerRoom;

  DateTime _dueDate;
  String _dateText='';

  String uuid;
  String nik;
  String customer_name;
  String room;

  void _editTask(){
    Firestore.instance.runTransaction((Transaction transaction) async{
      DocumentSnapshot snapshot =
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "nik" : nik,
        "customer_name": customer_name,
        "room": room,
        "due_date": _dueDate,

      });
    });
    Navigator.pop(context);
  }



  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2080)
    );

    if (picked != null){
      setState(() {
        _dueDate = picked;
        _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dueDate = widget.duedate;
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    uuid = widget.uuid;
    nik = widget.nik;
    customer_name = widget.customer_name;
    room = widget.room;

    controllerUuid = new TextEditingController(text: widget.uuid);
    controllerNik = new TextEditingController(text: widget.nik);
    controllerCustomerName = new TextEditingController(text: widget.customer_name);
    controllerRoom = new TextEditingController(text: widget.room);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: new AppBar(
        backgroundColor: Color.fromRGBO(47, 57, 84, 10),
        elevation: 0.1,
        title: Text('Edit Customer'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: null)
        ],
      ),
      body: Container(
      child: ListView(
        children: <Widget>[
          // Container(
          //   height: 200.0,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage("img/bg1.png"), fit: BoxFit.cover),
          //       color: Colors.teal),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text(
          //         "Smart DoorLock Admin",
          //         style: new TextStyle(
          //             color: Colors.white,
          //             fontSize: 30.0,
          //             letterSpacing: 2.0,
          //             fontFamily: "Pacifico"),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 20.0),
          //         child: Text(
          //           "Edit Customer",
          //           style: new TextStyle(fontSize: 24.0, color: Colors.white),
          //         ),
          //       ),
          //       Icon(
          //         Icons.list,
          //         color: Colors.white,
          //         size: 30.0,
          //       )
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerUuid,
              onChanged: (String str){
                setState(() {
                  uuid=str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.settings_ethernet),
                  // labelText: "UUID",
                  suffixText: 'UUID',
                  suffixStyle: const TextStyle(color: Colors.purple),
                  border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
              // style: new TextStyle(fontSize: 22.0, color: Colors.black),
              keyboardType: TextInputType.number,
              enabled: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(fontSize: 16),
              controller: controllerNik,
              onChanged: (String str){
                setState(() {
                  nik=str;
                });
              },
              autofocus: true,
              decoration: new InputDecoration(
                  icon: Icon(Icons.credit_card),
                  suffixText: 'NIK',
                  suffixStyle: const TextStyle(color: Colors.purple),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerCustomerName,
              onChanged: (String str){
                setState(() {
                  customer_name=str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.person),
                  suffixText: 'Name',
                  suffixStyle: const TextStyle(color: Colors.purple),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
              style: new TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: new Icon(Icons.date_range),
                ),
                new Expanded(child: Text("Due Date", style: new TextStyle(fontSize: 22.0, color: Colors.black54),)),
                new FlatButton(
                    onPressed: ()=>_selectDueDate(context),
                    child: Text(_dateText, style: new TextStyle(fontSize: 22.0, color: Colors.black54),)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerRoom,
              onChanged: (String str){
                setState(() {
                  room=str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.room),
                  suffixText: 'Room',
                  suffixStyle: const TextStyle(color: Colors.purple),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
              keyboardType: TextInputType.number,
              enabled: false,
            ),
          ),
          Divider(),
           ListTile(
              title: RaisedButton(
                child: const Text('Save'),
                color: Color.fromRGBO(150, 38, 123, 10),
                textColor: Colors.white,
                onPressed: () {
                  _editTask();
                },
              ),
            ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 100.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: <Widget>[
          //       IconButton(
          //           icon: Icon(Icons.check, size: 40.0,),
          //           onPressed: (){
          //             _editTask();

          //           }
          //       ),
          //       IconButton(
          //           icon: Icon(Icons.close, size: 40.0,),
          //           onPressed: (){
          //             Navigator.pop(context);
          //           }
          //       ),
          //     ],
          //   ),
          // )

        ],
      ),
      ),
    );
  }
}
