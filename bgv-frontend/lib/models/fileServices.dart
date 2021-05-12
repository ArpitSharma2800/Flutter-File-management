import 'package:bgv/models/file.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Services {
  Services({this.pincode, this.date});
  final int pincode;
  final DateTime date;

  static Future<List<FileClass>> getdata() async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String urlDate = formatter.format(now);
      String url = 'http://localhost:3000/orgfile';
      print(url);
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final List<FileClass> dataList = fileClassFromJson(response.body);
        int session = dataList.length;
        print(session);
        return dataList;
      } else {
        print('dataList');
        List<FileClass> file = [];
        return file;
      }
    } catch (e) {
      print(e);
      List<FileClass> file = [];
      return file;
    }
  }
}
