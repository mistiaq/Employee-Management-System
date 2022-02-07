import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class daily_attendence extends StatefulWidget {
  @override
  _attendencestate createState() => _attendencestate();
}
class _attendencestate extends State<daily_attendence> {
  Future uploadDateTime() async{
    final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection("Employee Table")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("Daily Attendence")
    .doc(nows.toString())
    .set({"time": x, "date": y})
    .whenComplete(() => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }
  showSnackBar(String text, Duration d) {
    final snackText = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackText);
  }
  String x = "";
  String y = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController _time = TextEditingController();
    TextEditingController _date = TextEditingController();
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
                child: ElevatedButton(
                  onPressed: () {
                    _changedDate();
                  },
                  child: const Text("Select Today's Date"),
                ),
              ),
            ),
            Container(
              height: 400,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 80),
                          width: 200,
                          height: 200,
                          child: Text(
                            "Current Time: \n\n${x}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Container(
                          padding: EdgeInsets.all(5),
                          width: 200,
                          height: 120,
                          child: Text(
                            "Today's Date: \n\n${y}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadDateTime();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> showSnackBar("uploaded", Duration(milliseconds: 400))));
                    },
                    child: const Text(
                      "Upload",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                  ),

                ],
              ),
            )
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
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => getvalue(value.format(context).toString())));
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.format(context))));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("There is something wrong!!!")));
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
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text(formatted)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("There is something wrong!!!")));
        }
      });
    });
  }
}
