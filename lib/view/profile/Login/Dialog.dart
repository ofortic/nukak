import 'package:flutter/material.dart';
import 'package:nukak/constants.dart';
import 'package:nukak/view/home/HomeView.dart';
import 'package:nukak/view/profile/profile.dart';

enum DialogAction { Aceptar }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
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
            "¡Registro exitoso!",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Muy pronto estaremos en contacto contigo para terminar el proceso de registro",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                        (Route<dynamic> route) => false);
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
