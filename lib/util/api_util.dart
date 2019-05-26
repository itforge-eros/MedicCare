///
/// `api_util.dart`
///

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class APIUtil {
  static Future<dynamic> fetchPost() async {
    final response = await http.get('https://api.fda.gov/drug/event.json?limit=100');
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'].map((e) => e['patient']['drug']).toList();
    }
  }

  static Future<dynamic> getMedicineNameList() async {
    List<dynamic> resultList = List<dynamic>();

    await fetchPost().then((value) {
      value.forEach((e) {
        resultList += e;
      });
    });

    return resultList.map((e) => e['medicinalproduct']).toList();
  }
}
