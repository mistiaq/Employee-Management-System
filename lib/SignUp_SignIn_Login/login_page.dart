import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class login_page extends StatefulWidget{
  @override
  _login_state createState() => _login_state();
}

class _login_state extends State<login_page> {
  String img = 'assets/img.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 450,
                width: 400,
                child: Image.asset(img),
              )
          ],
        ),
      )
        );
  }
}
