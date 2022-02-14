import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class write_task extends StatefulWidget {
  const write_task({Key? key}) : super(key: key);

  @override
  _write_taskState createState() => _write_taskState();
}

class _write_taskState extends State<write_task> {
  var userid;
  Future upload_task(a,b,c)async{
    CollectionReference ref = FirebaseFirestore.instance.collection("Employee Table");
    try{
      if(a.toString() == null){
        Common_Toast().customtoast("You Should Provide Title Must", Duration(milliseconds: 500));
      }
      else{
        userid = FirebaseAuth.instance.currentUser!.uid.toString();
        ref.doc(userid)
            .collection("Tasks")
          .add({"title": a, "desc":b, "schedule": c})
        .whenComplete(() => Common_Toast().customtoast("Uploaded", Duration(milliseconds: 400)));
      }
    } on Exception catch (e){
      Common_Toast().customtoast(e.toString(), Duration(milliseconds: 400));
    }
  }
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController schedule = TextEditingController();
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
                  controller: desc,
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
                    "Schedule",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                child: TextField(
                  controller: schedule,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter time or day to finish the task",
                  ),
                ),
              ),
              Container(
                  child: ElevatedButton(
                    clipBehavior: Clip.hardEdge,
                      onPressed: () {
                        upload_task(title.text, desc.text, schedule.text);
                      },
                      child: Text("Upload", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))))
            ],
          ),
        ),
      ),
    );
  }
}
