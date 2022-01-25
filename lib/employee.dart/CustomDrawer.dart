import 'package:employee_manegement/employee.dart/profile_emp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

import '../main.dart';
import 'dashboard_emp.dart';

class customdrawer extends StatefulWidget {

  @override
  _customdrawerState createState() => _customdrawerState();
}


class _customdrawerState extends State<customdrawer> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 175,
          ),
          ListTile(
            leading: Icon(Icons.account_box_rounded,color: Colors.blue,),
            title: Text("JOE PARKARRR!!!" ,style: TextStyle(color: Colors.blue),),
          ),
          ListTile(
            leading: Icon(Icons.dashboard,color: Colors.blue,),
            title: Text("Dashboard" ,style: TextStyle(color: Colors.blue),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> dashboard_emp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined,color: Colors.blue,),
            title: Text("Profile" ,style: TextStyle(color: Colors.blue),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> profile_emp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded,color: Colors.blue,),
            title: Text("Log Out" ,style: TextStyle(color: Colors.blue),),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyApp()));
            },
          ),
        ],
      ),
    );
  }
}
