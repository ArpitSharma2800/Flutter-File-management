import 'dart:html';

import 'package:bgv/components/home/src/homeDashbaord.dart';
import 'package:bgv/components/navigation/navigationBar.dart';
import 'package:bgv/models/file.dart';
import 'package:bgv/models/fileServices.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  final String page;
  final String extra;
  const Home({Key key, this.page, this.extra}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              NavigationBar([true, false, false, false]),
              //dashboard
              Dashbaord()
            ],
          )),
    );
  }
}

class Dashboard {}
