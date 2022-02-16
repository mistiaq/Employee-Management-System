import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({Key? key}) : super(key: key);

  @override
  _LeaveApplicationState createState() => _LeaveApplicationState();
}
var Subject = TextEditingController();
var Description = TextEditingController();
var Time = TextEditingController();
class _LeaveApplicationState extends State<LeaveApplication> {
  Future upload_application(a,b,c) async{
    final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
      CollectionReference ref = FirebaseFirestore.instance.collection("Admin");
      Map<String, dynamic> leave_applications = <String, dynamic>{
        "Subject": a,
        "Description": b,
        "Time": c,
        "uid":FirebaseAuth.instance.currentUser!.uid.toString(),
      };
    await ref
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Leave Application")
        .doc(nows.toString())
        .set(leave_applications).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }
  showSnackBar(String text, Duration d) {
    final snackText = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackText);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          // color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Title*",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                child: TextField(
                  controller: Subject,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter Title",
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                child: TextField(
                  maxLines: 12,
                  controller: Description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter Description",
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                child: TextField(
                  controller: Time,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter date to take leave on ",
                  ),
                ),
              ),
              Container(
                  child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      onPressed: () {
                        upload_application(Subject.text, Description.text, Time.text);
                      },
                      child: Text("Upload", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))))
            ],
          ),
        ),
      ),
    );
  }
}