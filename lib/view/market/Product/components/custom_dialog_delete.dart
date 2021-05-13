import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nukak/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nukak/models/product.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;

class CustomDialogDelete extends StatelessWidget {
  final String title, descriptions, text;
  final Image img;
  final Product product;
  final BuildContext ancestorContext;
  const CustomDialogDelete(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.ancestorContext,
      this.product})
      : super(key: key);

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
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "No",
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          db
                              .deleteProduct(product.shopId, product)
                              .then((value) {
                            int count = 0;
                            Navigator.of(context)
                              ..popUntil((_) => count++ >= 2);
                          });
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
