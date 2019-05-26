///
/// `shared_preferences_util.dart`
/// Class contains shared preferences and file reading/writing methods
/// Source: Reading docs and copied from them.
/// 

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class SharedPreferencesUtil {
  // Utility Method: Save last email
  static void saveLastEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  // Utility Method: Load last email
  static Future<String> loadLastEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('email'));
  }

  // Utility Method: Save app enter count
  static void saveAppOpenCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('appOpenCount', count);
  }

  // Utility Method: Load app enter count
  static Future<int> loadAppOpenCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getInt('appOpenCount'));
  }

  // Utility Method: Get local path
  static Future<String> getLocalPath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Utility Method: Get local file
  static Future<File> getLocalFile({String fileName = 'data.txt'}) async {
    final String path = await getLocalPath();
    return File(path + '/' + fileName);
  }

  // Utility Method: Read file content from a specific file
  static Future<String> readFileContent({String fileName = 'data.txt'}) async {
    try {
      final file = await getLocalFile(fileName: fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  // Utility Method: Write file content from a specific file
  static void writeFileContent({String fileName = 'data.txt', String data = ''}) async {
    final file = await getLocalFile(fileName: fileName);
    file.writeAsString(data);
  }
}
