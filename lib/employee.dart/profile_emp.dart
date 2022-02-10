import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/employee.dart/profile_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class profile_emp extends StatefulWidget {
  @override
  _profile_empState createState() => _profile_empState();
}


// class FireStorageService extends ChangeNotifier{
//   // FireStorageService._();
//   FireStorageService();
//
//   // static Future<dynamic> loadFromStorage(BuildContext context, String image) async{
//   //   return await FirebaseStorage
//   //       .instance
//   //       .ref()
//   //       .child(FirebaseAuth.instance.currentUser!.uid)
//   //       .child("profile-pic")
//   //       .child(image)
//   //       .getDownloadURL();
//   //   // throw ("Platform not found");
//   // }
// }
class _profile_empState extends State<profile_emp> {

  // Future<Widget> _getImage(BuildContext context, String image) async{
  //   Image image;
  //   await FireStorageService.loadFromStorage(context, image).then((downloadURL){
  //     image = Image.network(
  //       downloadURL.toString(),
  //       fit: BoxFit.scaleDown,
  //     );
  //   });
  //   return image;
  // }
  File? image;
  @override
  // Future<Widget> build(BuildContext context, AsyncSnapshot<dynamic> snapshot) async{
  //   var downloadURL = "https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png";
  //   return FutureBuilder(
  //     future: FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid).child("profile-pic").child("oa76BYeBMXZLdxKtpzR3").getDownloadURL(),
  //       builder: (context, snapshot){
  //       if(snapshot.connectionState == ConnectionState.done)
  //         return Container(
  //           height: MediaQuery.of(context).size.height /1.25,
  //             width: MediaQuery.of(context).size.width/1.25,
  //             child: Image.network(
  //               snapshot.data .toString(),
  //               fit: BoxFit.scaleDown,
  //             ),
  //         );
  //       if(snapshot.connectionState == ConnectionState.waiting)
  //         return Container(
  //           height: MediaQuery.of(context).size.height /1.25,
  //             width: MediaQuery.of(context).size.width/1.25,
  //             child: CircularProgressIndicator(),
  //         );
  //         return Container();
  //       },
  //   );

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

            // Image.network(downloadURL),
            // Image.network(downloadURL),
            // StreamBuilder(
            //     stream: _stream,
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       // String url = snapshot.data!.docs[index]['downloadURL'];
            //

            //       if (!snapshot.hasData) {
            //         return Center(
            //         child: Container(
            //             height: 400,
            //             width: 400,
            //             // alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               border: Border.all(color: Colors.grey),
            //               color: Colors.grey,
            //               image: const DecorationImage(
            //                 image: NetworkImage(
            //                     "https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png"),
            //                 fit: BoxFit.cover,
            //                 alignment: Alignment.center,
            //               ),
            //             )),
            //       );
            //       } else {
            //         return Center(
            //                   child: Image.network(
            //                     url,
            //                     width: 400,
            //                     height: 400,
            //                     fit: BoxFit.cover,
            //                   ),
            //                 );
            //       }
            //     }),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(
            //         height: 35,
            //         width: 324,
            //         color: Colors.blue,
            //         // decoration:
            //         // BoxDecoration(border: Border.all(color: Colors.black)),
            //         child: Center(
            //             child: Text('Select / Update Your Profile Picture')
            //         )
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     ElevatedButton(
            //         onPressed: () {}, child: Icon(Icons.upload_rounded))
            //   ],
            // ),

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
            // Container(
            //   margin: EdgeInsets.all(10),
            //   height: 100,
            //   width: 400,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black),
            //   ),
            //   child: Column(
            //     children: const [
            //       Text('\nMohammad Istiaq Uddin',
            //           style: TextStyle(fontSize: 20)),
            //       Text('\nSoftware Developer, Flutter\n'),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.all(10),
            //   height: 40,
            //   width: 400,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black),
            //   ),
            //   child: Row(
            //     children: const [
            //       Text('  Bio: ',
            //           style: TextStyle(
            //             fontSize: 18,
            //           )),
            //       // TextField(
            //       //   controller: bio_controller,
            //       //     decoration: InputDecoration(
            //       //       hintText: 'Ex: Learner',
            //       //     ),
            //       // )
            //     ],
            //   ),
            // ),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   margin: EdgeInsets.all(10),
            //   height: 100,
            //   width: 400,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: const [
            //       Expanded(
            //           flex: 1,
            //           child: Text('\n  LinkedIn Profile: ',
            //               style: TextStyle(fontSize: 15))),
            //       Expanded(
            //           flex: 1,
            //           child: Text('\n  Github Profile: ',
            //               style: TextStyle(fontSize: 15))),
            //     ],
            //   ),
            // ),
            SizedBox(),
            //this is Edit Profile Button
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => profile_edit()));
                },
                child: Text("Edit Profile"))
          ],
        ),
      ),
    );
  }
  // loadButton(context),
}
