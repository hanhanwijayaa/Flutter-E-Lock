import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/MyTask.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import './MyTask.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await firebaseAuth.signInWithCredential(
        credential);
    final FirebaseUser firebaseUser = authResult.user;
//    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
//        idToken: googleSignInAuthentication.idToken,
//        accessToken: googleSignInAuthentication.accessToken
//    );
//    aneh asli


    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) =>
            new MyTask(user: firebaseUser, googleSignIn: googleSignIn)
        )
    );

    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg.jpg"), fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset("img/logo.png", width: 250.0,),
            new Padding(padding: const EdgeInsets.only(bottom: 30.0),),
            new InkWell(
                onTap: () {
                  _signIn();
                },
                child: new Image.asset("img/btn_login.png", width: 220.0,)),
          ],
        ),
      ),
    );
  }
}

