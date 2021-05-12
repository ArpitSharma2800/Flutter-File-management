import 'dart:html';

import 'package:bgv/components/alert/src/alertDashboard.dart';
import 'package:bgv/components/navigation/navigationBar.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  final String page;
  final String extra;
  const Alert({Key key, this.page, this.extra}) : super(key: key);

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333951),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff333951),
        title: Text("VarSpace",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
      ),
      body: Container(
          // color: HexColor(ColorsDesign['primary']),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              //sidebar
              NavigationBar([
                false,
                false,
                true,
                false,
              ]),
              //dashboard
              AlertDashbaord()
            ],
          )),
    );
  }
}

class Dashboard {}
