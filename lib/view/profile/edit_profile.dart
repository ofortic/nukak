import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/controller/storage_service.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../constants.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  @override
  File _imageFile;
  TextEditingController myNameController = TextEditingController();
  TextEditingController myCityController = TextEditingController();
  TextEditingController myPhoneController = TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myNameController.dispose();
    myCityController.dispose();
    myPhoneController.dispose();
  }

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
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
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Editar perfil",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: Container(
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
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        snapshot.data.url,
                                      ),
                                    ),
                                  ),
                                )),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      if (_imageFile != null) {
                                        StorageService ss =
                                            context.read<StorageService>();
                                        ss
                                            .uploadImageToFirebase(
                                                context, _imageFile)
                                            .then((value1) {
                                          ss
                                              .getDownloadUrl(context, value1)
                                              .then((value) {
                                            UserHelper.updateProfilePic(
                                                    firebaseUser.uid, value)
                                                .then((value) {
                                              print('Data updated');
                                              int count = 0;
                                              Navigator.of(context)
                                                ..popUntil((_) => count++ >= 2);
                                            });
                                          });
                                        });
                                      } else {
                                        print('No file');
                                      }
                                    },
                                    icon: new Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          controller: myNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Nombre',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data.name,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (myNameController.text.trim().length > 0) {
                                  UserHelper.updateUserName(firebaseUser.uid,
                                          myNameController.text)
                                      .then((value) {
                                    print('Data updated');
                                    int count = 0;
                                    Navigator.of(context)
                                      ..popUntil((_) => count++ >= 2);
                                  });
                                } else {
                                  print('no new name');
                                }
                              },
                              icon: Icon(Icons.save),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          controller: myCityController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Ciudad',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data.city,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (myCityController.text.trim().length > 0) {
                                  UserHelper.updateCity(firebaseUser.uid,
                                          myCityController.text)
                                      .then((value) {
                                    print('Data updated');
                                    int count = 0;
                                    Navigator.of(context)
                                      ..popUntil((_) => count++ >= 2);
                                  });
                                } else {
                                  print('no new name');
                                }
                              },
                              icon: Icon(Icons.save),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          controller: myPhoneController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Teléfono',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data.tel,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (myPhoneController.text.trim().length > 0) {
                                  UserHelper.updatePhone(firebaseUser.uid,
                                          myPhoneController.text)
                                      .then((value) {
                                    print('Data updated');
                                    int count = 0;
                                    Navigator.of(context)
                                      ..popUntil((_) => count++ >= 2);
                                  });
                                } else {
                                  print('no new name');
                                }
                              },
                              icon: Icon(Icons.save),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
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

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
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
