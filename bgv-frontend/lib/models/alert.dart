// To parse this JSON data, do
//
//     final alertClass = alertClassFromJson(jsonString);

import 'dart:convert';

List<AlertClass> alertClassFromJson(String str) =>
    List<AlertClass>.from(json.decode(str).map((x) => AlertClass.fromJson(x)));

String alertClassToJson(List<AlertClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlertClass {
  AlertClass({
    this.alertId,
    this.fileName,
    this.userId,
  });

  String alertId;
  String fileName;
  String userId;

  factory AlertClass.fromJson(Map<String, dynamic> json) => AlertClass(
        alertId: json["AlertId"],
        fileName: json["FileName"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "AlertId": alertId,
        "FileName": fileName,
        "userId": userId,
      };
}
