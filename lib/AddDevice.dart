import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class AddDevices extends StatefulWidget {
  AddDevices({this.email});
  final email;

  @override
  _AddDevicesState createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  final FocusNode fn1 = FocusNode();
  final FocusNode fn2 = FocusNode();

  String snDevices;
  String roomName;
  String staffAccess;
  String staffName;
  var getUuidStaff;
  var uuidStaff;

  String get;
  String idCard;

  final mainReference = FirebaseDatabase.instance.reference();
  var selectedCurrecy, selectedType;

  void _addData(){

    getUuidStaff = idCard.split(",");
    var uuidStaff = getUuidStaff[1];

//====================realtime database
    mainReference.child('devices').child(snDevices)
        .set({
//      'serial_number' : uuid,
      'entried' : widget.email,
      'sn' : snDevices,
      'id': "$roomName,$snDevices,$uuidStaff,$staffName",
      'room' : roomName,
      'uuid_staff': uuidStaff,
      'staffName': staffName,
//      'status': 'available',
    });
//==========================================

//=============== create to cloud firestore databassse =================
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
      Firestore.instance.collection('devices');
      await reference.add({
        'entried' : widget.email,
        'sn' : snDevices,
        'id': "$roomName,$snDevices,$uuidStaff,$staffName",
        'room' : roomName,
        'uuid_staff': uuidStaff,
        'staffName': staffName,
//        'status': 'available',
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
        title: Text('Add Device Room'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.devices, color: Colors.white,), onPressed: null)
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
                      snDevices = str;
                    });
                  },
                  autofocus: true,
//                    controller: _textFieldController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.settings_ethernet),
                    labelText: "Serial Number",
                    helperText: 'Add serial number device for applied to room',
                    suffixText: 'SN',
                    suffixStyle: const TextStyle(color: Colors.purple),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
                  keyboardType: TextInputType.number,
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
                        roomName = str;
                      });
                    },
//                    focusNode: FocusNode(),
//                    controller: _textFieldController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.store_mall_directory),
                      labelText: "Room Name",
                      helperText: 'Add room name for device, exp Room1',
                      suffixText: 'Name',
                      suffixStyle: const TextStyle(color: Colors.purple),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                    ),
                    textCapitalization: TextCapitalization.words,
                    focusNode: fn2,
                  ),
                )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//=====================get from cloud dropdown=========
                SizedBox(
                  height: 40.0,
                  width: 50.0,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("idCard")
                      .where("entried", isEqualTo: widget.email)
                      .snapshots(),

                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return new Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      List<DropdownMenuItem> currencyItems = [];
                      int i;
                      for (i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];

                        currencyItems.add(DropdownMenuItem(
                          child: Text(
                            get = snap.data['id'],
                            style: TextStyle(color: Colors.black),
                          ),
                          value: snap.data['id'],
                        ));
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.credit_card,
                              size: 25.0,
                              color: Colors.teal,
                            ),
                            SizedBox(
                              width: 50.0,
                            ),
                            DropdownButton(
                              items: currencyItems,
                              onChanged: (currencyValue) {
                                idCard = currencyValue;


                                setState(() {
                                  selectedCurrecy = currencyValue;
                                });
                              },
                              value: selectedCurrecy,
                              hint: Text(
                                'Selected Staff Access',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
//        =====================================
              ],
            ),


            ListTile(
                title : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        staffName = str;
                      });
                    },
                    focusNode: FocusNode(),
//                    controller: _textFieldController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Staff Name",
                      helperText: 'Staff name who works the room',
                      suffixText: 'Name',
                      suffixStyle: const TextStyle(color: Colors.purple),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                    ),
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
