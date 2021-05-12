import 'package:bgv/models/alert.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertServices {
  static Future<List<AlertClass>> getalert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId');
    try {
      String url = 'http://localhost:3000/alert/$id';
      print(url);
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final List<AlertClass> dataList = alertClassFromJson(response.body);
        int session = dataList.length;
        print(session);
        return dataList;
      } else {
        print('dataList');
        List<AlertClass> file = [];
        return file;
      }
    } catch (e) {
      print(e);
      List<AlertClass> file = [];
      return file;
    }
  }
}
