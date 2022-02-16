import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ShowTasks.dart';
import 'WriteTask.dart';

class task_manager extends StatefulWidget {
  const task_manager({Key? key}) : super(key: key);

  @override
  _task_managerState createState() => _task_managerState();
}

class _task_managerState extends State<task_manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Employee Table")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Tasks")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (!snapshot.hasData) Text("No Task is given yet xyz");
            return Container(
                child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.waiting || snapshot.hasData) {
                  return Center(
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: (){

                              String uid = snapshot.data!.docs[index].id.toString();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> show_tasks(uid)));

                                // if(snapshot.hasData){
                                //   Container(
                                //     height: 50,
                                //       width: MediaQuery.of(context).size.width,
                                //   child: Column(
                                //     children: [
                                //       Text(snapshot.data!.docs[index]["title"])
                                //     ],
                                //   ),
                                // );}
                            },
                            title: Text(snapshot.data!.docs[index]["title"]),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                // else if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasError)
                //   return Card (elevation: 2, child: Text("No data is there"));
                else {
                  return Card(elevation: 2, child: Text("No Task is given"));
                }
              },
            ));
          },

        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(40),
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => write_task()));
                },
                child: Icon(Icons.note_add_outlined),
              ),
            ),
          ],
        ));
  }

}
