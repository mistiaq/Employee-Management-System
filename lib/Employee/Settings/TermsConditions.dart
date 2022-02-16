import 'package:flutter/material.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.topCenter,

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
        // Text('Hello world'),
        Image.asset("assets/images/terms.jpg"),
      ),
    );
  }
}
