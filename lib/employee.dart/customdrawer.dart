import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/employee.dart/profile_emp.dart';
import 'package:employee_manegement/employee.dart/_attenedence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

import '../demo4all.dart';
import '../main.dart';
import 'dashboard_emp.dart';
import '../national/model.dart';

class customdrawer extends StatefulWidget {
  @override
  _customdrawerState createState() => _customdrawerState();
}

class _customdrawerState extends State<customdrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinUser = UserModel();



  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(loggedinUser.uid)
        .get()
        .then((value) {
      this.loggedinUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
   final _empTable =
        FirebaseFirestore.instance.collection("Employee Table").doc(user!.uid).get();

   return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 175,
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: FutureBuilder(
              future: _empTable,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return ListTile(
                  leading: Icon(
                    Icons.account_box_rounded,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "${data["First Name"]}  ${data["Last Name"]}",
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.blue,
              ),
              title: Text(
                "Dashboard",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Firebasedemo()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.fingerprint_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "Daily Attendence",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => daily_attendence()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: Colors.blue,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => profile_emp()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ),
        ],
      ),
    );
  }
}