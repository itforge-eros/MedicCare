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
    List<dynamic> objectList = List<dynamic>(); // Variable: List contains raw objects
    List<dynamic> resultList = List<dynamic>(); // Variable: List contains string of medicine names

    // Step #1: Fetch for objects and store them in `objectList`
    await fetchPost().then((value) {
      value.forEach((e) {
        objectList += e;
      });
    });

    // Step #2: Add medicine names to `resultList`
    objectList.forEach((e) {
      if (!resultList.contains(e['medicinalproduct'])) {
        resultList.add(e['medicinalproduct']);
      }
    });

    // Step #3: String formatting of medicine names in `resultList`
    for (int i = 0; i < resultList.length; i++) {
      // Step #3.1: Capitalization
      resultList[i] = resultList[i][0].toUpperCase() + resultList[i].replaceRange(0, 1, '').toLowerCase();

      // Step #3.2: Removes brackets and string in it
      if (resultList[i].contains('(') && resultList[i].contains(')')) {
        resultList[i] = resultList[i].replaceRange(
          resultList[i].indexOf(' ('),
          resultList[i].indexOf(')') + 1,
          '',
        );
      }

      // Step #3.3: Removes the ending dot
      if (resultList[i][resultList[i].length - 1] == '.') {
        resultList[i] = resultList[i].replaceRange(resultList[i].length - 1, resultList[i].length, '');
      }
    }

    // Step #4: Returns `resultList`
    return resultList;
  }
}
