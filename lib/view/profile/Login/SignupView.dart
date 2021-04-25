import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/profile/Login/LoginView.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name;
    String em;
    String pass1;
    String pass2;
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
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              hintText: "Correo electrónico",
              onChanged: (value) {
                em = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Contraseña",
              onChanged: (value) {
                pass1 = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Confirma contraseña",
              onChanged: (value) {
                pass2 = value;
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {
                    if ((pass1 == pass2) &&
                        (pass1 != null) &&
                        (pass2 != null)) {
                      context
                          .read<AuthenticationService>()
                          .signUp(
                            email: em,
                            password: pass1,
                          )
                          .then((value) {
                        UserHelper.saveUser(value.user).then((uid) {
                          print(uid);
                          UserHelper.updateUserName(uid, name).then((value) {
                            context
                                .read<AuthenticationService>()
                                .signOut()
                                .then((value) => Navigator.of(context).pop());
                          });
                        });
                      });
                    } else {
                      print('invalid');
                    }
                  },
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
