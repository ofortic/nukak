import 'package:firebase_auth/firebase_auth.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/models/request.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/profile/edit_profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:nukak/controller/db.dart' as db;
import '../../../constants.dart';

class RequestView extends StatelessWidget {
  Request request;
  RequestView({Key key, @required this.request}) : super(key: key);
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return FutureBuilder(
        future: UserHelper.getUser(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }
          return Scaffold(
            appBar: getAppBarHome(context),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  request.url,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildTextField("Descripción", request.reason),
                    if (request.checked) buildTextField("Revisado", "Si"),
                    if (!request.checked) buildTextField("Revisado", "No"),
                    if (request.approved) buildTextField("Aprobado", "Si"),
                    if (!request.approved) buildTextField("Aprobado", "No"),
                    SizedBox(
                      height: 35,
                    ),
                    if (snapshot.data.role == 'admin')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              db.updateChecked(request.id).then((value) {
                                db.updateApproved(request.id).then((value) {
                                  UserHelper.updateRole(
                                      request.userId, 'craftsman');
                                  Navigator.of(context).pop();
                                });
                              });
                            },
                            color: kPrimaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Aprobar",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  color: Colors.white),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              db.updateChecked(request.id).then((value) {
                                Navigator.of(context).pop();
                              });
                            },
                            color: kPrimaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Rechazar",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        enabled: false,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
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
            "assets/images/logonukak.png",
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
