import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class show_tasks extends StatefulWidget {
  final String documentId;
  // show_tasks(String uid, {Key? key}) : super(key: key);
  show_tasks(this.documentId);
  @override
  _show_tasksState createState() => _show_tasksState();
}

class _show_tasksState extends State<show_tasks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference _empTable = FirebaseFirestore.instance
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Tasks");
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _empTable.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("Title: ${data["title"]}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("Description:\n",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Container(
                      alignment: Alignment.topLeft,
                      color: Colors.white54,
                      child: Text(
                        "${data["desc"]}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("Scheduled to finish : ${data["schedule"]}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              // },

              // ),
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
