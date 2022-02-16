import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CustomDrawer.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  User? user;

  @override
  void initState(){
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }
  onRefresh(userCred){
    setState(() {
      user = userCred;
    });
  }
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    final Future<DocumentSnapshot> _empTable =
        FirebaseFirestore.instance.collection("Employee Table").doc(uid).get();
     return Scaffold(
      drawer: Drawer(
        child: customdrawer(),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _empTable,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              " Welcome ${data["First Name"]} ${data["Last Name"]}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              )),
                          SizedBox(
                            height: 15,
                          ),

                          Text("Co${data["Contact Number"]}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),

                          Text("${data["Email"]}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Image.network("https://t3.ftcdn.net/jpg/01/13/56/88/500_F_113568821_Biklsap72qysKy8ubkZAWM85GPkWeWKf.jpg"),
            SizedBox(
              height: 15,
            ),
            Text("Your Daily Tasks/ Assignments will be provided here: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  
}
