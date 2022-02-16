import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({Key? key}) : super(key: key);

  @override
  _DailyReportState createState() => _DailyReportState();
}
var title = TextEditingController();
var details = TextEditingController();
class _DailyReportState extends State<DailyReport> {

  Future upload_task(String a, String b) async{
    final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    CollectionReference ref = FirebaseFirestore.instance.collection("Admin");
    Map<String, dynamic> leave_applications = <String, dynamic>{
      "Title": a,
      "Described": b,
      "uid":FirebaseAuth.instance.currentUser!.uid.toString(),
    };
    await ref
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Daily Reports")
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
                  controller: title,
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
                  controller: details,
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
                  child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      onPressed: () {
                        upload_task(title.text, details.text);
                      },
                      child: Text("Upload", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))))
            ],
          ),
        ),
      ),
    );
  }
}

