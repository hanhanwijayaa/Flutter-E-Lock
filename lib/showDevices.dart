import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './editDevices.dart';

class showDevices extends StatefulWidget {
  showDevices({this.email});
  final email;

  @override
  _showDevicesState createState() => _showDevicesState();
}

class _showDevicesState extends State<showDevices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(47, 57, 84, 10),
        elevation: 0.1,
        title: Text('Devices Registered'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.devices, color: Colors.white,), onPressed: null)
        ],
      ),
      body: new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("devices")
                  .where("entried", isEqualTo: widget.email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                return new TaskList(
                  document: snapshot.data.documents,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  TaskList({this.document});

  final List<DocumentSnapshot> document;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
//        String uuid = document[i].data['uuid'].toString();
//        String nik = document[i].data['nik'].toString();
        String room = document[i].data['room'].toString();
        String staffName = document[i].data['staffName'].toString();
//        DateTime _date = document[i].data['due_date'].toDate();
        String serial = document[i].data['sn'].toString();
//        String due_date = "${_date.day}/${_date.month}/${_date.year}";

        return new Dismissible(
          key: new Key(document[i].documentID),
          onDismissed: (direction) {
            Firestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
              await transaction.get(document[i].reference);
              await transaction.delete(snapshot.reference);
            });

            FirebaseDatabase.instance
                .reference()
                .child('devices')
                .child(serial)
                .update({
              'room': '',
              'staffName': '',
              'sn': '',
//              'uuid': '',
            });

            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("Devices Deleted"),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 0.0, right: 16.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.store_mall_directory,
                                color: Colors.teal,
                              ),
                            ),
                            new Expanded(
                                child: Text(
                                  room,
                                  style: new TextStyle(
                                    fontSize: 22.0,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.teal,
                              ),
                            ),
                            new Expanded(
                                child: Text(
                                  "Staff Name : $staffName",
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.settings_ethernet,
                                color: Colors.teal,
                              ),
                            ),
                            new Expanded(
                                child: Text(
                                  "SN Device   : $serial",
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                new IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new editDevices(
//                          uuid: uuid,
//                          nik: nik,
//                          customer_name: customer_name,
//                          room: room,
//                          index: document[i].reference,
//                          duedate: _date,

//                          duedate: document[i].data['due_date'],
                        )));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

