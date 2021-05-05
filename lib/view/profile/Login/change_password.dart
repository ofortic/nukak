import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'Dialog.dart';

class ChangePass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: ChangePassword(),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  bool showPassword = false;
  @override
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController currentController = TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    newController.dispose();
    confirmController.dispose();
    currentController.dispose();
  }

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUser(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: getAppBarHome(context),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  child: ListView(
                    children: [
                      Text(
                        "Cambiar contraseña",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          controller: currentController,
                          obscureText: true ? showPassword : false,
                          decoration: InputDecoration(
                              suffixIcon: true
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Contraseña actual",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "********",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          controller: newController,
                          obscureText: true ? showPassword : false,
                          decoration: InputDecoration(
                              suffixIcon: true
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Nueva contraseña",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "********",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          controller: confirmController,
                          obscureText: true ? showPassword : false,
                          decoration: InputDecoration(
                              suffixIcon: true
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Confirmar contraseña",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "********",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlineButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (currentController.text.length > 0) {
                                UserHelper.validatePassword(
                                        firebaseUser, currentController.text)
                                    .then((value) {
                                  if (value) {
                                    if (newController.text.length > 0 &&
                                        newController.text ==
                                            confirmController.text) {
                                      UserHelper.updatePassword(
                                              firebaseUser, newController.text)
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    } else {
                                      print('passwords do not match');
                                    }
                                  } else {
                                    print('invalid pass');
                                  }
                                });
                              } else {
                                print('invalid pass');
                              }
                            },
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Guardar",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Loading();
        });
  }

  Widget getAppBarHome(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logonukak.png',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * 0.09,
            color: Colors.white60,
          ),
          Container(padding: const EdgeInsets.all(8.0))
        ],
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
    );
  }
}
