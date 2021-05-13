import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:nukak/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/controller/storage_service.dart';
import 'package:nukak/models/product.dart';
import 'package:nukak/models/shop.dart';
import 'package:nukak/view/profile/Login/accept_Decline_Modal.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions, text;
  final BuildContext ancestorContext;
  final Image img;
  final Shop shop;
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<File> imagesToUpload = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  CustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.ancestorContext,
      this.shop})
      : super(key: key);

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> showAcceptDeclineModal(
      BuildContext context, String description) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AceptDeclineModal(
              title: "", descriptions: description, text: "ok");
        });
  }

  Future<List<File>> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    List<File> fileImages = [];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#a8531b",
          actionBarTitle: "Nukak",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    print(resultList.length);
    resultList.forEach((imageAsset) async {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

      File tempFile = File(filePath);
      if (tempFile.existsSync()) {
        fileImages.add(tempFile);
      }
    });

    return fileImages;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    StorageService ss = ancestorContext.read<StorageService>();
    final firebaseUser = ancestorContext.watch<User>();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              /*
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),*/
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(168, 84, 27, 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextButton(
                    onPressed: () {
                      loadAssets().then((value) => imagesToUpload = value);
                    },
                    child: Text(
                      "Añadir Imagenes",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre del producto',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: descriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripcion',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          String url = '';
                          if (nameController.text.trim().length != 0 &&
                              descriptionController.text.trim().length != 0 &&
                              imagesToUpload.length != 0) {
                            if (imagesToUpload.length == 1) {
                              print(1);

                              ss
                                  .uploadImageToFirebase(
                                      context, imagesToUpload[0])
                                  .then((value1) {
                                ss
                                    .getDownloadUrl(context, value1)
                                    .then((value) {
                                  url += value;
                                  db
                                      .sendProduct(
                                          shop.id,
                                          Product(
                                              nameController.text,
                                              firebaseUser.uid,
                                              shop.id,
                                              descriptionController.text,
                                              url))
                                      .then((value) {
                                    Navigator.of(context).pop();
                                  });
                                });
                              });
                            }
                            if (imagesToUpload.length == 2) {
                              print(2);

                              ss
                                  .uploadImageToFirebase(
                                      context, imagesToUpload[0])
                                  .then((value1) {
                                ss
                                    .getDownloadUrl(context, value1)
                                    .then((value) {
                                  url += value;
                                  print(1);

                                  ss
                                      .uploadImageToFirebase(
                                          context, imagesToUpload[1])
                                      .then((value2) {
                                    ss
                                        .getDownloadUrl(context, value2)
                                        .then((value3) {
                                      url += ',' + value3;
                                      db
                                          .sendProduct(
                                              shop.id,
                                              Product(
                                                  nameController.text,
                                                  firebaseUser.uid,
                                                  shop.id,
                                                  descriptionController.text,
                                                  url))
                                          .then((value) {
                                        Navigator.of(context).pop();
                                      });
                                    });
                                  });
                                });
                              });
                            }
                            if (imagesToUpload.length == 3) {
                              print(3);
                              ss
                                  .uploadImageToFirebase(
                                      context, imagesToUpload[0])
                                  .then((value1) {
                                ss
                                    .getDownloadUrl(context, value1)
                                    .then((value) {
                                  url += value;
                                  ss
                                      .uploadImageToFirebase(
                                          context, imagesToUpload[1])
                                      .then((value2) {
                                    ss
                                        .getDownloadUrl(context, value2)
                                        .then((value3) {
                                      url += ',' + value3;
                                      ss
                                          .uploadImageToFirebase(
                                              context, imagesToUpload[2])
                                          .then((value4) {
                                        ss
                                            .getDownloadUrl(context, value4)
                                            .then((value5) {
                                          url += ',' + value5;
                                          db
                                              .sendProduct(
                                                  shop.id,
                                                  Product(
                                                      nameController.text,
                                                      firebaseUser.uid,
                                                      shop.id,
                                                      descriptionController
                                                          .text,
                                                      url))
                                              .then((value) {
                                            Navigator.of(context).pop();
                                          });
                                        });
                                      });
                                    });
                                  });
                                });
                              });
                            }
                            if (imagesToUpload.length == 4) {
                              print(4);
                              ss
                                  .uploadImageToFirebase(
                                      context, imagesToUpload[0])
                                  .then((value1) {
                                ss
                                    .getDownloadUrl(context, value1)
                                    .then((value) {
                                  url += value;
                                  ss
                                      .uploadImageToFirebase(
                                          context, imagesToUpload[1])
                                      .then((value2) {
                                    ss
                                        .getDownloadUrl(context, value2)
                                        .then((value3) {
                                      url += ',' + value3;
                                      ss
                                          .uploadImageToFirebase(
                                              context, imagesToUpload[2])
                                          .then((value4) {
                                        ss
                                            .getDownloadUrl(context, value4)
                                            .then((value5) {
                                          url += ',' + value5;
                                          ss
                                              .uploadImageToFirebase(
                                                  context, imagesToUpload[3])
                                              .then((value6) {
                                            ss
                                                .getDownloadUrl(context, value6)
                                                .then((value7) {
                                              url += ',' + value7;
                                              db
                                                  .sendProduct(
                                                      shop.id,
                                                      Product(
                                                          nameController.text,
                                                          firebaseUser.uid,
                                                          shop.id,
                                                          descriptionController
                                                              .text,
                                                          url))
                                                  .then((value) {
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          });
                                        });
                                      });
                                    });
                                  });
                                });
                              });
                              /*
                            */
                            }
                          } else {
                            showAcceptDeclineModal(context, 'Datos invalidos');
                          }
                          //loadAssets();
                        },
                        child: Text(
                          "Si",
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/logo2nukak.png")),
          ),
        ),
      ],
    );
  }
}

class CustomDialogBoxUpdate extends StatelessWidget {
  final String title, descriptions, text;
  final BuildContext ancestorContext;
  final Image img;
  final Product product;
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<File> imagesToUpload = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  CustomDialogBoxUpdate(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.ancestorContext,
      this.product})
      : super(key: key);
  Future<void> showAcceptDeclineModal(
      BuildContext context, String description) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AceptDeclineModal(
              title: "", descriptions: description, text: "ok");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    StorageService ss = ancestorContext.read<StorageService>();
    final firebaseUser = ancestorContext.watch<User>();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              /*
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),*/
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre del producto',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: descriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripcion',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          String url = '';
                          if (nameController.text.trim().length == 0 &&
                              descriptionController.text.trim().length == 0) {
                            Navigator.of(context).pop();
                          }
                          if (nameController.text.trim().length != 0 &&
                              descriptionController.text.trim().length == 0) {
                            db
                                .updateProductName(product.shopId, product.id,
                                    nameController.text)
                                .then((value) {
                              int count = 0;
                              Navigator.of(context)
                                ..popUntil((_) => count++ >= 2);
                            });
                          }
                          if (nameController.text.trim().length == 0 &&
                              descriptionController.text.trim().length != 0) {
                            db
                                .updateProductDescription(product.shopId,
                                    product.id, descriptionController.text)
                                .then((value) {
                              int count = 0;
                              Navigator.of(context)
                                ..popUntil((_) => count++ >= 2);
                            });
                          }
                          if (nameController.text.trim().length != 0 &&
                              descriptionController.text.trim().length != 0) {
                            db
                                .updateProductName(product.shopId, product.id,
                                    nameController.text)
                                .then((value) {
                              db
                                  .updateProductDescription(product.shopId,
                                      product.id, descriptionController.text)
                                  .then((value) {
                                int count = 0;
                                Navigator.of(context)
                                  ..popUntil((_) => count++ >= 2);
                              });
                            });
                          }
                        },
                        child: Text(
                          "Si",
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/logo2nukak.png")),
          ),
        ),
      ],
    );
  }
}
