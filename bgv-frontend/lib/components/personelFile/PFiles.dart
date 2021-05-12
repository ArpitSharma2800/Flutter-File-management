import 'dart:html';

import 'package:bgv/components/navigation/navigationBar.dart';
import 'package:bgv/components/personelFile/src/pfileDashbaord.dart';
import 'package:flutter/material.dart';

class Pfile extends StatefulWidget {
  final String page;
  final String extra;
  const Pfile({Key key, this.page, this.extra}) : super(key: key);

  @override
  _PfileState createState() => _PfileState();
}

class _PfileState extends State<Pfile> {
  // bool loading = true;
  // bool hasData = false;
  // List<FileClass> dataList;

  // void setupApi() async {
  //   // print(pincode);
  //   setState(() {
  //     loading = true;
  //   });
  //   await Services.getdata().then((v) {
  //     setState(() {
  //       dataList = v;
  //       try {
  //         if (dataList.length > 0) {
  //           hasData = true;
  //         }
  //       } catch (e) {
  //         return e;
  //       }
  //       loading = false;
  //     });
  //     print(hasData);
  //   });
  // }

  // void initState() {
  //   super.initState();
  //   setupApi();
  // }

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
                true,
                false,
                false,
              ]),
              //dashboard
              DashbaordPfile()
            ],
          )),
    );
  }
}

class Dashboard {}
