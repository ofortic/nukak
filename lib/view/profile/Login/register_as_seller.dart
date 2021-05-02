import 'package:flutter/material.dart';

import 'package:nukak/view/profile/Login/LoginView.dart';

import '../../../constants.dart';
import 'Dialog.dart';

class RegisterSeller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name;
    String city;
    String description;
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
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Image.asset(
                  "assets/images/logonukak.png",
                ),
              ),
              Text(
                "Gracias por querer ser parte de Nukak, para iniciar tu inscripción, por favor ingresa los siguientes datos:",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35,
              ),
              RoundedInputField(
                hintText: "Nombre de tu empresa",
                onChanged: (value) {
                  name = value;
                },
              ),
              RoundedInputField(
                hintText: "Descripción de tu empresa",
                onChanged: (value) {
                  description = value;
                },
              ),
              RoundedInputField(
                hintText: "Ciudad de tu empresa",
                onChanged: (value) {
                  city = value;
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () {
                      Dialogs.yesAbortDialog(context);
                    },
                    child: Text(
                      "Registrarme",
                      style: TextStyle(color: new Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
