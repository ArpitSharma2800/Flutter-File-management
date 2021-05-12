import 'package:bgv/models/file.dart';
import 'package:bgv/models/fileServices.dart';
import 'package:bgv/models/pfiles.dart';
import 'package:bgv/models/pfileservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DashbaordPfile extends StatefulWidget {
  DashbaordPfile({Key key}) : super(key: key);

  @override
  _DashbaordPfileState createState() => _DashbaordPfileState();
}

class _DashbaordPfileState extends State<DashbaordPfile> {
  bool loading = true;
  bool hasData = false;
  List<PFileClass> dataList;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  showAlertDialog(BuildContext context, String file) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        generateAlert(file);
      },
    );
    Widget cancel = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete this file permanently?"),
      content: Text("Are you sure you want to do this?"),
      actions: [okButton, cancel],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogImage(BuildContext context, String file) {
    // set up the button
    Widget cancel = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Generate alert to uploader of this file?"),
      content: Image.network('http://localhost:3000/$file'),
      actions: [cancel],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void generateAlert(String file) async {
    Map map = {
      "fileId": '$file',
    };
    String body = json.encode(map);
    try {
      String url = 'http://localhost:3000/deletefile';
      final response = await http.delete(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      if (200 == response.statusCode) {
        setupApi();
        __displaySnackBarSuccess(context);
        Navigator.of(context).pop();
        return print('fe1');
      } else {
        __displaySnackBarError(context);
        return print(response.statusCode);
      }
    } catch (e) {
      __displaySnackBarError(context);
      return print(e);
    }
  }

  void setupApi() async {
    // print(pincode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId');
    setState(() {
      loading = true;
    });
    await PFServices.getdata(id).then((v) {
      setState(() {
        dataList = v;
        try {
          if (dataList.length > 0) {
            hasData = true;
          }
        } catch (e) {
          return e;
        }
        loading = false;
      });
      print(hasData);
    });
  }

  void initState() {
    super.initState();
    setupApi();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 100,
        child: ListView.builder(
            itemCount: hasData == false ? 0 : dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  trailing: Wrap(
                    spacing: 12,
                    children: [
                      IconButton(
                        icon: const Icon(Feather.delete),
                        color: Colors.red,
                        onPressed: () {
                          showAlertDialog(context, dataList[index].filesId);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        color: Colors.green,
                        onPressed: () {
                          showAlertDialogImage(
                              context, dataList[index].fileLink);
                        },
                      ),
                    ],
                  ),
                  title: Text(
                      " ${dataList[index].userName} uploaded File : ${dataList[index].fileLink}"));
            }),
      ),
    );
  }

  __displaySnackBarSuccess(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red[400],
      content: new Row(
        children: <Widget>[new Text("  File deleted...")],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  __displaySnackBarError(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red[400],
      content: new Row(
        children: <Widget>[new Text("  Not able to generate alert...")],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
