import 'package:flutter/material.dart';

class showStaff extends StatefulWidget {
  showStaff({this.email});
  final email;

  @override
  _showStaffState createState() => _showStaffState();
}

class _showStaffState extends State<showStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(47, 57, 84, 10),
        elevation: 0.1,
        title: Text('Staff Registered'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: null)
        ],
      ),
    );
  }
}
