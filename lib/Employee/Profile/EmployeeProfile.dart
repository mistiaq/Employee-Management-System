import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EditProfile.dart';

class profile_emp extends StatefulWidget {
  @override
  _profile_empState createState() => _profile_empState();
}
class _profile_empState extends State<profile_emp> {
  File? image;
  @override
  Widget build(BuildContext context){
    final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    final Future<DocumentSnapshot> _empTable =
    FirebaseFirestore.instance.collection("Employee Table").doc(uid).get();
    var downloadURL = "https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png";
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: _empTable,
              builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot){
                Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasError)
                  return Center(child: CircularProgressIndicator());
                else{
                  final String x = "${data["profile-pic"]}";
                  return Column(
                    children: [
                      x != null
                      ? Container( alignment: Alignment.topCenter,height: 500, width: MediaQuery.of(context).size.width,child: Image.network(x, fit: BoxFit.cover,))
                      : Image.network(downloadURL),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            Text(
                                "\n${data["First Name"]} ${data["Last Name"]}",
                                style: TextStyle(
                                    fontSize: 20
                                )),
                            Text('\n${data["Designation"]}\n'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 40,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children:  [
                            Text('  Bio: ${data["Bio"]}',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            // TextField(
                            //   controller: bio_controller,
                            //     decoration: InputDecoration(
                            //       hintText: 'Ex: Learner',
                            //     ),
                            // )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text('\n  LinkedIn Profile: ${data["LinkedIn"]}',
                                    style: TextStyle(fontSize: 14))),
                            Expanded(
                                flex: 1,
                                child: Text('  Github Profile: ${data["Github"]}',
                                    style: TextStyle(fontSize: 14))),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }
            ),

          ],
        ),
      ),
    );
  }
  // loadButton(context),
}
