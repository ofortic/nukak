import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/request.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:nukak/view/profile/Login/LoginView.dart';

import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import '../../../constants.dart';
import 'Dialog.dart';

class RegisterSeller extends StatelessWidget {
  @override
  String description;
  File _imageFile;

  final picker = ImagePicker();

  Future pickImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) _imageFile = File(pickedFile.path);
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) _imageFile = File(pickedFile.path);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        pickImageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camara'),
                    onTap: () {
                      pickImageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 215, 171, 1),
      appBar: getAppBarHome(context),
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
              Container(
                width: 170,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: TextButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.add_a_photo_rounded, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Adjuntar fotos",
                          style: TextStyle(
                              color: new Color.fromRGBO(0, 0, 0, 0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
