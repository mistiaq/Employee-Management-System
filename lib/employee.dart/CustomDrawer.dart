import 'package:employee_manegement/SignUp_SignIn_Login/login_page.dart';
import 'package:employee_manegement/SignUp_SignIn_Login/sign_up.dart';
import 'package:employee_manegement/demo4all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text("JOE PARKARRR!!!" ,style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> demo_for_all()));
            },
          )

        ],
      ),
    );
  }
}
