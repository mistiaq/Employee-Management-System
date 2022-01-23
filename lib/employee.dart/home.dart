import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomDrawer.dart';

class home extends StatefulWidget {

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: customdrawer(),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
