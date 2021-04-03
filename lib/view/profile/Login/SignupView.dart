import 'package:flutter/material.dart';
import 'package:nukak/view/profile/Login/LoginView.dart';

import '../../../constants.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                "assets/images/logonukak.png",
              ),
            ),
            RoundedInputField(
              hintText: "Nombres y Apellidos",
            ),
            RoundedInputField(
              hintText: "Correo electrónico",
            ),
            RoundedPasswordField(
              hintText: "Contraseña",
            ),
            RoundedPasswordField(
              hintText: "Confirma contraseña",
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: Text(
                    "Registrarme",
                    style: TextStyle(color: new Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                ),
              ),
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
