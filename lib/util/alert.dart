///
/// `alert.dart`
/// Class contains static methods to show alerts
///

import 'package:flutter/material.dart';

class Alert {
  static Future displayAlert({
    BuildContext context,
    String title,
    String content,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }

  static Future displayPrompt({
    BuildContext context,
    String title = '',
    String content = '',
    String prompt = 'OK',
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(prompt),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
