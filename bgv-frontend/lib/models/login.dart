// To parse this JSON data, do
//
//     final loginClass = loginClassFromJson(jsonString);

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bgv/models/file.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

LoginClass loginClassFromJson(String str) =>
    LoginClass.fromJson(json.decode(str));

String loginClassToJson(LoginClass data) => json.encode(data.toJson());

class LoginClass {
  LoginClass({
    this.message,
    this.userId,
  });

  String message;
  String userId;

  factory LoginClass.fromJson(Map<String, dynamic> json) => LoginClass(
        message: json["message"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
      };
}

class LoginService {
  static Future<LoginClass> getdata(String username, String pwd) async {
    Map map = {"username": '$username', "pwd": '$pwd'};
    String body = json.encode(map);
    try {
      String url = 'http://localhost:3000/login';
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      if (200 == response.statusCode) {
        final LoginClass dataList = loginClassFromJson(response.body);
        return dataList;
      } else {
        return LoginClass();
      }
    } catch (e) {
      return LoginClass();
    }
  }
}
