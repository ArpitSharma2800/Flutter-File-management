import 'dart:convert';

import 'package:bgv/components/navigation/src/Navbaritem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  List<bool> selected;
  NavBar(this.selected);

  @override
  _NavBarState createState() => _NavBarState(this.selected);
}

class _NavBarState extends State<NavBar> {
  List<bool> selected;
  _NavBarState(this.selected);
  void select(int n) {
    for (int i = 0; i < 4; i++) {
      // if (i != n) {
      //   selected[i] = false;
      // } else {
      //   selected[i] = true;
      // }
    }
  }

  void upload(
      BuildContext context, String file, String base64, String userId) async {
    print(userId);
    Map map = {
      "filename": '$file',
      "base64url": '$base64',
      "userId": '$userId'
    };
    String body = json.encode(map);
    try {
      String url = 'http://localhost:3000/upload';
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      if (200 == response.statusCode) {
        Navigator.of(context).pop();
        __displaySnackBarSuccess(context);
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

  showAlertDialogImage(BuildContext context) {
    // set up the button
    Widget cancel = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget add = FlatButton(
      child: Text(
        "Add File",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString('userId');
        FilePickerResult result = await FilePicker.platform.pickFiles();

        if (result != null) {
          PlatformFile file = result.files.first;
          upload(context, file.name, base64Encode(file.bytes), id);
          // print(file.name);
          // print(base64Encode(file.bytes));
          // print(file.size);
          // print(file.extension);
          // print(file.path);
        } else {
          // User canceled the picker
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Generate alert to uploader of this file?"),
      content: Text("FileName"),
      actions: [add, cancel],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      child: Column(
        children: [
          NavBarItem(
            icon: Feather.home,
            active: selected[0],
            touched: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/main');
                select(0);
              });
            },
          ),
          NavBarItem(
            icon: Feather.user,
            active: selected[1],
            touched: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/pfile');
                select(1);
              });
            },
          ),
          NavBarItem(
            icon: Feather.alert_circle,
            active: selected[2],
            touched: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/alert');
                select(2);
              });
            },
          ),
          NavBarItem(
            icon: Feather.plus_circle,
            active: selected[2],
            touched: () {
              setState(() {
                showAlertDialogImage(context);
                select(3);
              });
            },
          ),
        ],
      ),
    );
  }

  __displaySnackBarSuccess(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green[400],
      content: new Row(
        children: <Widget>[new Text("  File Uploaded...")],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  __displaySnackBarError(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red[400],
      content: new Row(
        children: <Widget>[new Text("  Not able to upload file...")],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
