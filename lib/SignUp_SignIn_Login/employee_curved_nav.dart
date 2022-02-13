import 'package:employee_manegement/SignUp_SignIn_Login/login_page.dart';
import 'package:employee_manegement/SignUp_SignIn_Login/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class employee_curved_nav extends StatefulWidget{
  @override
  nav_state createState()=> nav_state();
}

class nav_state extends State<employee_curved_nav>{
  void initState(){
    super.initState();
  }
  int myindex = 1;
  List pages  =
  [
    sign_up(),
    login_page(),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // home: Animated,


      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
          color: Colors.teal,
          height: 50,
          animationCurve: Curves.linearToEaseOut,
          index: 1,
          items: <Widget>[
            Icon(Icons.app_registration, size: 30,),
            Icon(Icons.add, size: 30,),
          ],
        onTap: (index){
          setState(() {
            myindex = index;
          });
        },
      ),
      body: pages[myindex],
    );
  }
}

