// To parse this JSON data, do
//
//     final pFileClass = pFileClassFromJson(jsonString);

import 'dart:convert';

List<PFileClass> pFileClassFromJson(String str) =>
    List<PFileClass>.from(json.decode(str).map((x) => PFileClass.fromJson(x)));

String pFileClassToJson(List<PFileClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PFileClass {
  PFileClass({
    this.filesId,
    this.fileLink,
    this.userId,
    this.userName,
  });

  String filesId;
  String fileLink;
  String userId;
  String userName;

  factory PFileClass.fromJson(Map<String, dynamic> json) => PFileClass(
        filesId: json["FilesId"],
        fileLink: json["FileLink"],
        userId: json["userId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "FilesId": filesId,
        "FileLink": fileLink,
        "userId": userId,
        "userName": userName,
      };
}
