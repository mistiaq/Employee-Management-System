import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customdrawer.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  loaddata() async {
    SharedPreferences preferences = await prefs;
    setState(() {
      s = preferences.getInt("value");
    });
  }

  var userid = FirebaseAuth.instance.currentUser!.uid;

  var s;
  File? image;
  @override
  void initState() {
    super.initState();
    loaddata();
  }

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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } if (snapshot.hasError) {
                  return Text("data is not found");
                }
                  return Center(
                    child: Container(
                      height: 500,
                      child: Column(
                        children: [
                          image != null
                              ? Image.file(
                                  image!,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )
                              : FlutterLogo(size: 160),
                          Text(
                            uid,
                            // userid.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(" My Full Name is : ${data["First Name"]}  ${data["Last Name"]}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),

                          Text("${data["Contact Number"]}",
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

                        ],
                      ),
                    ),
                  );
              },
            ),
            // FutureBuilder<DocumentSnapshot>(
            //   future: FirebaseFirestore.instance.collection('Employee Table').doc(uid).get(),
            //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot){
            //     if(snapshot.hasError)
            //     {
            //       return Text("Something Went Wrong");
            //     }
            //     if (snapshot.hasData && !snapshot.data!.exists) {
            //       return Text("Document does not exist");
            //     }
            //     if(snapshot.connectionState == ConnectionState.done){
            //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            //       return Text("Full Name: ${data["First Name"]} ${data["Last Name"]}");
            //     }
            //     return Text("loading");
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
