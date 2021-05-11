import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/profile/Login/SignupView.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class LoginView extends StatelessWidget {
  @override
  String us;
  String con;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Image.asset(
                  "assets/images/logo2nukak.png",
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.symmetric(vertical: 0),
                child: Image.asset("assets/images/fondologin.png"),
              ),
              RoundedInputField(
                hintText: "Correo electrónico",
                onChanged: (value) {
                  us = value;
                },
              ),
              RoundedPasswordField(
                hintText: "Contraseña",
                onChanged: (value) {
                  con = value;
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () {
                      context
                          .read<AuthenticationService>()
                          .signIn(
                            email: us,
                            password: con,
                          )
                          .then((value) => print(value));
                    },
                    child: Text(
                      "Ingresar",
                      style: TextStyle(color: new Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "¿No tienes una cuenta?",
                    style: TextStyle(color: new Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                  GestureDetector(
                    onTap: () {
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
                      "¡Registrate!",
                      style: TextStyle(
                        color: new Color.fromRGBO(0, 0, 0, 0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*SocialIcon(
                    iconSrt: "assets/images/facebook.png",
                    press: () {},
                  ),*/
                  SocialIcon(
                    iconSrt: "assets/images/google.png",
                    press: () {
                      context
                          .read<AuthenticationService>()
                          .signInWithGoogle()
                          .then((value) => print(value));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String iconSrt;
  final Function press;
  const SocialIcon({
    Key key,
    this.iconSrt,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Image.asset(iconSrt, height: 20, width: 20),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "O ingresa con",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: new Color.fromRGBO(0, 0, 0, 1),
        height: 1.5,
      ),
    );
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(login ? "¿Ya tienes una cuenta?" : "¿Ya tienes cuenta?",
            style: TextStyle(
              color: new Color.fromRGBO(0, 0, 0, 1),
              fontSize: 10,
            )),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "  Ingresar" : "Ingresar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.visibility),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
          ),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
