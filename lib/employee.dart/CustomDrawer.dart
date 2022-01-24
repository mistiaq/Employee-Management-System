import 'package:employee_manegement/employee.dart/profile_emp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

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
            height: 75,
          ),
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text("JOE PARKARRR!!!" ,style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard" ,style: TextStyle(color: Colors.black),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> dashboard_emp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Profile" ,style: TextStyle(color: Colors.black),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> profile_emp()));
            },
          ),

        ],
      ),
    );
  }
}
