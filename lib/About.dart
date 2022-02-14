import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Image.asset("assets/images/logo.jpg"),
            SizedBox(height: 10),
            Text("Mohammad Istiaq Uddin", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Undergraduate Student (Final Year) "),
            SizedBox(height: 10),
            Text("International Islamic University Chittagong", style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Follow me on Github: ",),
                // SizedBox(height: 10),
                InkWell(
                  onTap: _launchURL,
                  child: Text('www.github.com/IstiaqOsman',style: TextStyle(
                      color: Colors.blue, fontSize: 15, decoration: TextDecoration.underline,
                  ),),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
  _launchURL() async {
    const url = 'www.github.com/IstiaqOsman';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
