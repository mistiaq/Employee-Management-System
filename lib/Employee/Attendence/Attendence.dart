import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Home/Home.dart';
class daily_attendence extends StatefulWidget {
  @override
  _attendencestate createState() => _attendencestate();
}
class _attendencestate extends State<daily_attendence> {
  int i = 0;
  Future uploadDateTime() async {
    final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Daily Attendence")
        .doc(nows.toString())
        .set({"time": x, "date": y}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
    i++;
  }
  showSnackBar(String text, Duration d) {
    final snackText = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackText);
  }
  String x = '';
  String y = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(15),
                child: Card(
                  elevation: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      _changedTime();
                    },
                    child: const Text("Select Time"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                  elevation: 3,
                  color: Colors.white,
                  borderOnForeground: true,
                  child: Center(
                    child: Text(
                      "Current Time: ${x}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                elevation: 3,
                child: ElevatedButton(
                  onPressed: () {
                    _changedDate();
                  },
                  child: const Text("Select Today's Date"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                  elevation: 3,
                  color: Colors.white,
                  borderOnForeground: true,
                  child: Center(
                      child: Text(
                    "Today's Date: ${y}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (i == 0) {
                  if (x != "" && y != "") {
                    uploadDateTime();
                  } else {
                    showSnackBar(
                        "Please Select Time and Date", const Duration(milliseconds: 500));
                  }
                } else {
                  showSnackBar(
                      "You have submitted once", const Duration(milliseconds: 500));
                }
              },
              child: const Text(
                "Upload",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _changedTime() {
    setState(() {
      DateTime now = DateTime.now();
      showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      ).then((TimeOfDay? value) {
        if (value != null) {
          x = value.format(context).toString();
          }
      });
    });
  }

  _changedDate() {
    setState(() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now(),
      ).then((DateTime? value) {
        if (value != null) {
          final DateFormat formatter = DateFormat('dd-MM-yyyy');
          final String formatted = formatter.format(value);
          y = formatted;
        }
      });
    });
  }
}
