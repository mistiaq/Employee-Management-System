import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CustomDrawer.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  // loaddata() async {
  //   SharedPreferences preferences = await prefs;
  //   setState(() {
  //     s = preferences.getInt("value");
  //   });
  // }

  var userid = FirebaseAuth.instance.currentUser!.uid;

  var s;
  File? image;
  final _imageUrls = [
    "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
    "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
    "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final Future<DocumentSnapshot> _empTable =
        FirebaseFirestore.instance.collection("Employee Table").doc(uid).get();
     return Scaffold(
      drawer: Drawer(
        child: customdrawer(),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _empTable,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Container(
                      height: 500,
                      child: Column(
                        children: [
                          // ImageSlideshow(
                          //   width: double.infinity,
                          //   height: 200,
                          //   initialPage: 0,
                          //   indicatorColor: Colors.blue,
                          //   indicatorBackgroundColor: Colors.grey,
                          //   onPageChanged: (value) {
                          //     debugPrint('Page changed: $value');
                          //   },
                          //   autoPlayInterval: 3000,
                          //   isLoop: true,
                          //   children: [
                          //     Image.asset(
                          //       'images/sample_image_1.jpg',
                          //       fit: BoxFit.cover,
                          //     ),
                          //     Image.asset(
                          //       'images/sample_image_2.jpg',
                          //       fit: BoxFit.cover,
                          //     ),
                          //     Image.asset(
                          //       'images/sample_image_3.jpg',
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ],
                          // ),
                          // image != null
                          //     ? Image.file(
                          //   image!,
                          //   width: 160,
                          //   height: 160,
                          //   fit: BoxFit.cover,
                          // )
                          //     : FlutterLogo(size: 160),
                          // Text(
                          //   uid,
                          //   style: TextStyle(
                          //       fontSize: 20, fontWeight: FontWeight.bold),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              " Welcome : ${data["First Name"]}  ${data["Last Name"]}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),

                          Text("${data["Contact Number"]}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),

                          Text("${data["Email"]}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              )),

                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // FutureBuilder<DocumentSnapshot>(
            //   future: FirebaseFirestore.instance.collection('Employee Table').doc(uid).get(),
            //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot){
            //     if(snapshot.hasError)
            //     {
            //       return Text("Something Went Wrong");
            //     }
            //     if (snapshot.hasData && !snapshot.data!.exists) {
            //       return Text("Document does not exist");
            //     }
            //     if(snapshot.connectionState == ConnectionState.done){
            //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            //       return Text("Full Name: ${data["First Name"]} ${data["Last Name"]}");
            //     }
            //     return Text("loading");
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
