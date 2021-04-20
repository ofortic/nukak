import 'package:flutter/material.dart';
import 'package:nukak/constants.dart';
import 'package:nukak/view/profile/Login/LoginView.dart';
import 'package:nukak/view/profile/Login/SignupView.dart';

class ProfileViewLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return welcomeview(context);
  }

  Widget welcomeview(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Image.asset("assets/images/logonukak.png"),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "Bienvenido, te invitamos a iniciar sesión para continuar",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            width: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginView();
                      },
                    ),
                  );
                },
                child: Text(
                  "Ingresar",
                  style: TextStyle(color: new Color.fromRGBO(111, 31, 10, 1)),
                ),
              ),
            ),
          ),
          Container(
            width: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignupView();
                      },
                    ),
                  );
                },
                child: Text(
                  "Registrarse",
                  style: TextStyle(color: new Color.fromRGBO(111, 31, 10, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
