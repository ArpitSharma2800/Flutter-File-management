import 'package:bgv/models/file.dart';
import 'package:bgv/models/pfiles.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class PFServices {
  static Future<List<PFileClass>> getdata(String userId) async {
    try {
      String url = 'http://localhost:3000/file/$userId';
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final List<PFileClass> dataList = pFileClassFromJson(response.body);
        int session = dataList.length;
        print(session);
        return dataList;
      } else {
        print('dataList');
        List<PFileClass> file = [];
        return file;
      }
    } catch (e) {
      print(e);
      List<PFileClass> file = [];
      return file;
    }
  }
}
