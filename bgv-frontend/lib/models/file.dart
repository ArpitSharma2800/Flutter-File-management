// To parse this JSON data, do
//
//     final fileClass = fileClassFromJson(jsonString);

import 'dart:convert';

List<FileClass> fileClassFromJson(String str) =>
    List<FileClass>.from(json.decode(str).map((x) => FileClass.fromJson(x)));

String fileClassToJson(List<FileClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileClass {
  FileClass({
    this.filesId,
    this.fileLink,
    this.userId,
    this.userName,
  });

  String filesId;
  String fileLink;
  String userId;
  String userName;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
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
