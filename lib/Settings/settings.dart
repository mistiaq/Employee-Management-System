import 'package:employee_manegement/Employee/Profile/EditProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../About.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 50,
            width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => profile_edit()));
                },
                child: Card(
                  child: Center(
                    child: Text("Edit Profile", style:TextStyle(fontSize: 15)),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
            width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => about()));
                },
                child: Card(
                  child: Center(
                    child: Text("About Developer", style:TextStyle(fontSize: 15)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
