import 'dart:convert';

import 'package:bgv/models/login.dart';
import 'package:bgv/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final myControllerPassword = TextEditingController();
  final myControllerEmail = TextEditingController();
  bool hovered = false;

  void login(String username, String pwd) async {
    await LoginService.getdata(username, pwd).then((data) async {
      if (data.userId != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', data.userId);
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        __displaySnackBarError(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(ColorsDesign['primary']),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        IconButton(
                            icon: FaIcon(FontAwesomeIcons.user),
                            iconSize: 35,
                            onPressed: () {
                              print("Pressed");
                            }),
                        SizedBox(height: 10),
                        Text("Welcome Back!", style: TextStyle(fontSize: 28))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width > 780
                                    ? MediaQuery.of(context).size.width * 0.3
                                    : MediaQuery.of(context).size.width * 0.7,
                                child: TextFormField(
                                    style: TextStyle(
                                        color: HexColor(ColorsDesign['third'])),
                                    controller: myControllerEmail,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.supervised_user_circle_outlined,
                                          color:
                                              HexColor(ColorsDesign['third']),
                                        ),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color:
                                                HexColor(ColorsDesign['third']),
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color:
                                                HexColor(ColorsDesign['third']),
                                            width: 2.0,
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'username',
                                        labelStyle: TextStyle(
                                            color: HexColor(
                                                ColorsDesign['third']))),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter username';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width > 780
                                    ? MediaQuery.of(context).size.width * 0.3
                                    : MediaQuery.of(context).size.width * 0.7,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: HexColor(ColorsDesign['third'])),
                                  controller: myControllerPassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.security,
                                      color: HexColor(ColorsDesign['third']),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: HexColor(ColorsDesign['third']),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: HexColor(ColorsDesign['third']),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: HexColor(ColorsDesign['third'])),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            )
                          ])),
                    ),
                    // SizedBox(height: 10),
                    MouseRegion(
                      onEnter: (value) {
                        setState(() {
                          hovered = true;
                        });
                      },
                      onExit: (value) {
                        setState(() {
                          hovered = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacementNamed(
                          //     context, '/main/arpit');

                          if (_formKey.currentState.validate()) {
                            // Login process
                            login(myControllerEmail.text,
                                myControllerPassword.text);
                          }
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => BottomNav()));
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 275),
                          height: hovered ? 40 : 40,
                          width: hovered ? 200.0 : 195.0,
                          child: Center(
                            child: Text(
                              "Login".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: hovered
                                      ? HexColor(ColorsDesign['fifth'])
                                      : HexColor(ColorsDesign['third'])),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: hovered
                                  ? HexColor(ColorsDesign['third'])
                                  : HexColor(ColorsDesign['fifth']),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20.0,
                                  spreadRadius: 5.0,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have a account ? ",
                              style: TextStyle(
                                  color: HexColor(ColorsDesign['fourth']))),
                          Text(" Sign up now!",
                              style: TextStyle(
                                  color: HexColor(ColorsDesign['third']))),
                        ]),
                  ]),
            ),
          ),
        ));
  }

  __displaySnackBarError(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red[400],
      content: new Row(
        children: <Widget>[new Text("  Not able to sign in...")],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
