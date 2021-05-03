import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/request.dart';

import 'package:nukak/view/profile/Login/LoginView.dart';

import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import '../../../constants.dart';
import 'Dialog.dart';

class RegisterSeller extends StatelessWidget {
  @override
  String description;
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
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
                hintText: "Descripcion de tu empresa",
                onChanged: (value) {
                  description = value;
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
                      db
                          .sendRequest(Request(firebaseUser.uid, description))
                          .then((value) => Navigator.of(context).pop());
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
