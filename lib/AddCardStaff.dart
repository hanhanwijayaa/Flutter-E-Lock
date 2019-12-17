import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class AddCardStaff extends StatefulWidget {
  AddCardStaff({this.email});
  final email;

  @override
  _AddCardStaffState createState() => _AddCardStaffState();
}

class _AddCardStaffState extends State<AddCardStaff> {
  final FocusNode fn1 = FocusNode();
  final FocusNode fn2 = FocusNode();

  String idCard;
  String nameCard;
  final mainReference = FirebaseDatabase.instance.reference();

  void _addData(){
//=============== create to cloud firestore databassse =================
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
      Firestore.instance.collection('idCard');
      await reference.add({
        "entried": widget.email,
        "idCard": idCard,
        "nameCard": nameCard,
        "id": "$nameCard,$idCard",
      });
    });
//  ===============================================================

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(47, 57, 84, 10),
        elevation: 0.1,
        title: Text('Add Card Staff'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.credit_card, color: Colors.white,), onPressed: null)
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Divider(),
            ListTile(
                title : TextField(
                  onChanged: (String str) {
                    setState(() {
                      idCard = str;
                    });
                  },
                  autofocus: true,
//                    controller: _textFieldController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.credit_card),
                    labelText: "ID Card",
                    helperText: 'Add ID Card Staff, U see this in back of card',
                    suffixText: 'ID',
                    suffixStyle: const TextStyle(color: Colors.purple),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: fn1,
                  onSubmitted: (term) {
                    fn1.unfocus();
                    FocusScope.of(context).requestFocus(fn2);
                  },
                )
            ),

            ListTile(
                title : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                      nameCard = str;
                      });
                    },
//                    focusNode: FocusNode(),
//                    controller: _textFieldController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Card Name",
                      helperText: 'Add name for initialize this card, exp Staff1',
                      suffixText: 'Name',
                      suffixStyle: const TextStyle(color: Colors.purple),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    focusNode: fn2,
                  ),
                )
            ),
            Divider(),
            ListTile(
              title: RaisedButton(
                child: const Text('Add'),
                color: Color.fromRGBO(150, 38, 123, 10),
                textColor: Colors.white,
                onPressed: () {
                  _addData();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
