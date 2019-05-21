///
/// `alert.dart`
/// Class contains static methods to show alerts
///

import 'package:flutter/material.dart';

class Alert {
  static Future displayAlertPlain(
    BuildContext context, {
    String title = '',
    String content = '',
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

  static Future displayAlert(
    BuildContext context, {
    String title = '',
    String content = '',
    String confirm = 'OK',
    Function onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(confirm),
              onPressed: onPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
            )
          ],
        );
      },
    );
  }

  static Future displayConfirmProceed(
    BuildContext context, {
    String title = '',
    String content = '',
    String cancel = 'CANCEL',
    String confirm = 'OK',
    Function onPressedCancel,
    Function onPressedConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.grey,
              child: Text(cancel),
              onPressed: onPressedCancel ??
                  () {
                    Navigator.of(context).pop();
                  },
            ),
            FlatButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              child: Text(confirm),
              onPressed: onPressedConfirm ??
                  () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
            )
          ],
        );
      },
    );
  }

  static Future displayConfirmDelete(
    BuildContext context, {
    String title = '',
    String content = '',
    String cancel = 'CANCEL',
    String confirm = 'DELETE',
    Function onPressedCancel,
    Function onPressedConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.grey,
              child: Text(cancel),
              onPressed: onPressedCancel ??
                  () {
                    Navigator.of(context).pop();
                  },
            ),
            FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(confirm),
              onPressed: onPressedConfirm ??
                  () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
            )
          ],
        );
      },
    );
  }
}
