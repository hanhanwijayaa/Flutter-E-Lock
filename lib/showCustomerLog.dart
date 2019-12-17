import 'package:flutter/material.dart';

class showCustomerLog extends StatefulWidget {
  showCustomerLog({this.email});
  final email;

  @override
  _showCustomerLogState createState() => _showCustomerLogState();
}

class _showCustomerLogState extends State<showCustomerLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(47, 57, 84, 10),
        elevation: 0.1,
        title: Text('Customer Log'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.history, color: Colors.white,), onPressed: null)
        ],
      ),
    );
  }
}
