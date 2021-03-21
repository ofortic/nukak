import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/chat.dart';
import 'package:nukak_maku/models/product.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    final firebaseUser = context.watch<User>();
    return Scaffold(
        appBar: AppBar(title: Text(product.name)),
        body: new Container(
          color: Color(0xff258DED),
          height: 400.0,
          alignment: Alignment.center,
          child: new Column(
            children: [
              new Container(
                child: new Text(
                  product.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
              ),
              new Container(
                child: new Text(
                  product.datetime.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
              ),
              new Container(
                child: ElevatedButton(
                  child: Text('Contact Craftsman'),
                  onPressed: () {
                    db.sendChat(Chat(product.userId, firebaseUser.uid));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
