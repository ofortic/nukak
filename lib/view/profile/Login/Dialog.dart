import 'package:flutter/material.dart';
import 'package:nukak/constants.dart';
import 'package:nukak/view/home/HomeView.dart';
import 'package:nukak/view/root_app.dart';

enum DialogAction { Aceptar }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String description,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            description,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: kPrimaryColor,
                  child: const Text(
                    'Aceptar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.Aceptar;
  }
}
