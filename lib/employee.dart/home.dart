import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/employee.dart/imageupload/image_upload.dart';
import 'package:employee_manegement/employee.dart/imageupload/show_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customdrawer.dart';
import 'model.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}
class _homeState extends State<home> {
  final String userId = FirebaseFirestore.instance.collection("Employee Table").doc().id;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        });
    });
  }
  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 150,
              child: Image.asset("assets/logo.png", fit: BoxFit.contain),
            ),
            Text(
              userId,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                )),
            Text("${loggedInUser.email}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => imageupload(
                          userId: loggedInUser.uid,
                        )));
              },
              child: const Text("Upload Image"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            showimages(userId: loggedInUser.uid)));
              },
              child: const Text("Show Uploads"),
            ),
          ],
        ),
      ),
    );
  }
}
