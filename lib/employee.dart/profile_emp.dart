import 'package:employee_manegement/employee.dart/imageupload/show_images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'imageupload/image_upload.dart';
import '../national/model.dart';

class profile_emp extends StatefulWidget {
  @override
  _profile_empState createState() => _profile_empState();
}

class _profile_empState extends State<profile_emp> {
  // User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinUser = UserModel();

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("Employee Table")
  //       .doc(loggedinUser.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedinUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  UploadTask? task;
  File? image;

  TextEditingController bio_controller =  TextEditingController();

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    try {
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  String img = 'assets/small-avatar.png';
  // String img = 'assets/jpg_avatar.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            const SizedBox(
              height: 10,
            ),
            image != null
                ? Center(
                  child: Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                )
                : Center(
                  child: Container(
                      height: 400,
                      width: 400,
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey,
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png"),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      )),
                ),
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
            Container(
              margin: EdgeInsets.all(10),
              height: 100,
                width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: [
                  const Text('\nMohammad Istiaq Uddin', style: TextStyle(fontSize: 20)),
                  const Text('\nSoftware Developer, Flutter\n'),
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
                children: const [
                  Text('  Bio: ', style: TextStyle(fontSize: 18,)),
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
                children: const [
                  Expanded(flex: 1,child: Text('\n  LinkedIn Profile: ', style: TextStyle(fontSize: 15))),
                  Expanded(flex: 1,child: Text('\n  Github Profile: ', style: TextStyle(fontSize: 15))),
                ],
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 imageupload(userId: loggedinUser.uid)));
            //   },
            //   child: const Icon(Icons.cloud_upload_outlined),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     // selectfile;
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 showimages(userId: loggedinUser.uid)));
            //   },
            //   child: const Icon(Icons.camera_alt_outlined),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
          ElevatedButton(onPressed: (){}, child:Text("Edit Profile"))
          ],
        ),
      ),
    );
  }
}
