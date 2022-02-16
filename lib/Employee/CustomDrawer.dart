import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/Employee/Report/DailyReport.dart';
import 'package:employee_manegement/SignUp_SignIn_Login/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DemoCrud.dart';
import '../main.dart';
import 'Attendence/Attendence.dart';
import 'Profile/EmployeeProfile.dart';
import 'Settings/Settings.dart';
import 'Task Management/TaskManager.dart';

class customdrawer extends StatefulWidget {
  @override
  _customdrawerState createState() => _customdrawerState();
}

class _customdrawerState extends State<customdrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _empTable = FirebaseFirestore.instance
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: _empTable,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData) {
                  return Container(
                    height: 300,
                    width: 300,
                    child: Image.network(
                      "${data["profile-pic"]}",
                        fit: BoxFit.cover,
                        // scale: 0.5,
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          SizedBox(
            height: 10,
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: FutureBuilder(
                future: _empTable,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasError) {
                    return CircularProgressIndicator();
                  } else {
                    return ListTile(
                      leading: Icon(
                        Icons.account_box_rounded,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "${data["First Name"]}  ${data["Last Name"]}",
                        style: TextStyle(color: Colors.blue),
                      ),
                    );
                  }
                }),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: Colors.blue,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => profile_emp()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.fingerprint_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "Daily Attendence",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => daily_attendence()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.task_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "Tasks",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => task_manager()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.event_note,
                color: Colors.blue,
              ),
              title: Text(
                "Daily Report",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DailyReport()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => settings()));
              },
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.red,
            margin: EdgeInsets.all(10),
            color: Colors.yellowAccent,
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.blue,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => login_page()));
              },
            ),
          ),
        ],
      ),
    );
  }

}
