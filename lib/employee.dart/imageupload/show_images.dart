import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showimages extends StatefulWidget {
  String? userId;

  showimages({Key? key, this.userId}) : super(key: key);

  @override
  _showimagesState createState() => _showimagesState();
}

class _showimagesState extends State<showimages> {
  var userid = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Show Images")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Employee Table")
            .doc(userid)
            .collection("images")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return (const Center(
              child: Text("No image uploaded"),
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  String url = snapshot.data!.docs[index]['downloadURL'];
                  return SingleChildScrollView(
                    child: Image.network(
                      url,
                      height: 700,
                      fit: BoxFit.cover,
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
