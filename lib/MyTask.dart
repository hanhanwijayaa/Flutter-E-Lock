import './main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './MainPage.dart';
import './AddDevice.dart';
import './editTask.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import './AddCardStaff.dart';
import './showDevices.dart';
import './showStaff.dart';
import 'showCustomerLog.dart';

class MyTask extends StatefulWidget {
  MyTask({this.user, this.googleSignIn});

//  final mainReference = FirebaseDatabase.instance.reference().child('58578');

  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  void _signOut() {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: new Image.network(widget.user.photoUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Sign Out? as ${widget.user.displayName}",
                style: new TextStyle(fontSize: 16.0),
              ),
            ),
            new Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    widget.googleSignIn.signOut();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      Text("Yes")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      Text("Cancel")
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[

//    onPressed: () {
//          Navigator.of(context).push(new MaterialPageRoute(
//              builder: (BuildContext context) => MainPage(
//                email: widget.user.email,
//              )));
//        },

    return Scaffold(
      appBar: new AppBar(
        title: Text("Admin Dashoard"),
        backgroundColor: Color.fromRGBO(47, 57, 84, 10),
        elevation: 0.1,
        centerTitle: true,
//        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName),
              accountEmail: Text(widget.user.email),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(widget.user.photoUrl),
                  backgroundColor: Colors.transparent,
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(47, 57, 84, 10),
                image: DecorationImage(
                  image: AssetImage('img/drawer.png'),
                  fit: BoxFit.cover
                )
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text("Dashboard"),
                leading: Icon(Icons.home,  color: Colors.teal,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => showDevices(
                      email: widget.user.email,
                    )));
              },
              child: ListTile(
                title: Text("Devices"),
                leading: Icon(Icons.devices,  color: Colors.teal,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => showStaff(
                  email: widget.user.email,
                  )));
              },
              child: ListTile(
                title: Text("Staff"),
                leading: Icon(Icons.people, color: Colors.teal,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => showCustomerLog(
                      email: widget.user.email,
                    )));
              },
              child: ListTile(
                title: Text("Customer Log"),
                leading: Icon(Icons.history, color: Colors.teal,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                _signOut();
              },
              child: ListTile(
                title: Text("Sign Out"),
                leading: Icon(Icons.exit_to_app, color: Colors.red,),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Color.fromRGBO(150, 38, 123, 10),
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.teal,
            label: 'Add Customer',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => MainPage(
                        email: widget.user.email,
                      )));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.devices),
            backgroundColor: Colors.blue,
            label: 'Add Devices',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => AddDevices(
                        email: widget.user.email,
                      )));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.credit_card),
            backgroundColor: Colors.lime,
            label: 'Add Card Staff',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => AddCardStaff(
                        email: widget.user.email,
                      )));
            },
          ),
        ],
//
      ),

//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      bottomNavigationBar: new BottomAppBar(
//        elevation: 20.0,
//        color: Colors.teal,
//        child: ButtonBar(
//          children: <Widget>[],
//        ),
//      ),

      body: new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("customer_booking")
                  .where("email", isEqualTo: widget.user.email)
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
//          Container(
//            height: 170.0,
//            width: double.infinity,
//            decoration: BoxDecoration(
////                image: DecorationImage(
////                    image: new AssetImage("img/bg1.png"), fit: BoxFit.cover),
////                boxShadow: [
////                  new BoxShadow(color: Colors.black, blurRadius: 8.0)
////                ],
//                color: Color.fromRGBO(47, 57, 84, 10)),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Padding(
//                  padding: const EdgeInsets.all(18.0),
////                  child: Row(
////                    children: <Widget>[
////                      Container(
////                          width: 60.0,
////                          height: 60.0,
////                          decoration: BoxDecoration(
////                              shape: BoxShape.circle,
////                              image: DecorationImage(
////                                  image: new NetworkImage(widget.user.photoUrl),
////                                  fit: BoxFit.cover))),
////                      new Expanded(
////                        child: new Padding(
////                          padding: const EdgeInsets.all(10.0),
////                          child: new Column(
////                            mainAxisAlignment: MainAxisAlignment.center,
////                            crossAxisAlignment: CrossAxisAlignment.start,
////                            children: <Widget>[
////                              new Text(
////                                "Wellcome",
////                                style: new TextStyle(
////                                    fontSize: 18.0, color: Colors.white),
////                              ),
////                              new Text(
////                                widget.user.displayName,
////                                style: new TextStyle(
////                                    fontSize: 24.0, color: Colors.white),
////                              ),
////                            ],
////                          ),
////                        ),
////                      ),
////                      new IconButton(
////                          icon: Icon(
////                            Icons.exit_to_app,
////                            color: Colors.white,
////                            size: 30.0,
////                          ),
////                          onPressed: () {
////                            _signOut();
////                          }),
////
//////                      new IconButton(
//////                        icon: Icon(
//////                          Icons.add,
//////                          color: Colors.white,
//////                          size: 30.0,
//////                        ),
//////                        onPressed: () {
//////                          Navigator.of(context).push(new MaterialPageRoute(
//////                              builder: (BuildContext context) => AddDevice(
//////                                email: widget.user.email,
//////                              )));
//////                        },)
////                    ],
////                  ),
//                ),
//                new Text(
//                  "Admin Dashboard",
//                  style: new TextStyle(
//                      color: Colors.white,
//                      fontSize: 30.0,
//                      letterSpacing: 2.0,
//                      fontFamily: "Pacifico"),
//                )
//              ],
//            ),
//          ),
        ],
      ),
    );
//      ],
//    );
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
        String uuid = document[i].data['uuid'].toString();
        String nik = document[i].data['nik'].toString();
        String room = document[i].data['room'].toString();
        String customer_name = document[i].data['customer_name'].toString();
        DateTime _date = document[i].data['due_date'].toDate();
        String serial = document[i].data['sn'].toString();
        String due_date = "${_date.day}/${_date.month}/${_date.year}";

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
              'customer_name': '',
              'due_date': '',
              'nik': '',
              'uuid': '',
            });

            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("Customer Deleted"),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            customer_name,
                            style: new TextStyle(
                                fontSize: 20.0, letterSpacing: 1.0),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.teal,
                              ),
                            ),
                            new Expanded(
                                child: Text(
                              due_date,
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
                                Icons.room,
                                color: Colors.teal,
                              ),
                            ),
                            new Expanded(
                                child: Text(
                              "${room}",
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
                        builder: (BuildContext context) => new editTask(
                              uuid: uuid,
                              nik: nik,
                              customer_name: customer_name,
                              room: room,
                              index: document[i].reference,
                              duedate: _date,

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
