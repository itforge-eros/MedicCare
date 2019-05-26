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

  static Future<dynamic> getMedicineNameList({String pattern = ''}) async {
    List<dynamic> objectList = List<dynamic>(); // Variable: List contains raw objects
    List<dynamic> nameList = List<dynamic>(); // Variable: List contains string of medicine names
    List<dynamic> resultList =
        List<dynamic>(); // Variable: List contains filtered string of medicine names

    // Step #1: Fetch for objects and store them in `objectList`
    await fetchPost().then((value) {
      value.forEach((e) {
        objectList += e;
      });
    });

    // Step #2: Add medicine names to `nameList`
    objectList.forEach((e) {
      if (!nameList.contains(e['medicinalproduct'].trim())) {
        nameList.add(e['medicinalproduct'].trim());
      }
    });

    // Step #3: String formatting of medicine names in `nameList`
    for (int i = 0; i < nameList.length; i++) {
      // Step #3.1: Capitalization
      nameList[i] = nameList[i][0].toUpperCase() + nameList[i].replaceRange(0, 1, '').toLowerCase();

      // Step #3.2: Removes brackets and string in it
      if (nameList[i].contains('(') && nameList[i].contains(')')) {
        nameList[i] = nameList[i].replaceRange(
          nameList[i].indexOf(' ('),
          nameList[i].indexOf(')') + 1,
          '',
        );
      }

      // Step #3.3: Removes the ending dot
      if (nameList[i][nameList[i].length - 1] == '.') {
        nameList[i] = nameList[i].replaceRange(nameList[i].length - 1, nameList[i].length, '');
      }
    }

    // Step #4: Filtering
    if (pattern.trim().isNotEmpty) {
      nameList.forEach((e) {
        try {
          if (e.toLowerCase().contains(pattern.trim().toLowerCase())) {
            resultList.add(e);
          }
        } catch (e) {
          resultList.add(e);
        }
      });
    } else {
      resultList = nameList;
    }

    // Step #5: Sorting
    resultList.sort((a, b) => a.compareTo(b));

    // Step #6: Returns `resultList`
    return resultList;
  }
}
