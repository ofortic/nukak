import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/constants.dart';
import 'package:nukak/models/product.dart';
import 'package:nukak/models/shop.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/Product/ProductView.dart';
import 'package:nukak/view/market/Product/components/custom_dialog_box.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../constants.dart';
import '../../controller/authentication_service.dart';
import '../../controller/authentication_service.dart';
import '../../controller/authentication_service.dart';

class MarketView extends StatelessWidget {
  final Shop shop;

  // In the constructor, require a Todo.
  MarketView({Key key, @required this.shop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 215, 171, 1),
      appBar: getAppBarHome(context),
      body: getBody(context, shop, firebaseUser),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          getUserOwner(shop.userId);
        },
        child: const Icon(Icons.location_on_rounded),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

Future getUserOwner(String id) async {
  var googleMapsUrl = '';
  try {
    await UserHelper.getUserChat(id).then((snapshot) {
      googleMapsUrl = adressFormat(snapshot.city);
      print(googleMapsUrl);
      _launchURL(snapshot.city);
    });
  } catch (e) {
    print(e.toString());
    return null;
  }
}

String adressFormat(String adress) {
  var adressFormated = "";
  adress.runes.forEach((int i) {
    var letter = new String.fromCharCode(i);
    if (letter == " ") {
      adressFormated = adressFormated + "+";
    } else {
      if (letter == "#") {
        adressFormated = adressFormated + "%23";
      }
    }
    //print(letter);
  });
  return adressFormated;
}

_launchURL(String googleUrl) async {
  print(googleUrl);
  var url = 'https://www.google.com/maps/place/' + googleUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget getBody(BuildContext context, Shop shop, User fbu) {
  //getUserOwner(shop.userId);
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/Background.png"), fit: BoxFit.cover),
    ),
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.38,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              getProfilePhoto(context, shop),
              SizedBox(height: 10),
              if (fbu.uid == shop.userId) getDescription(shop, context),
              if (fbu.uid != shop.userId) getDescriptionUser(shop, context),
            ],
          ),
        ),
        Expanded(
          child: getList(shop),
        ),
      ],
    ),
  );
}

Widget getProfilePhoto(BuildContext context, Shop shop) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.all(10.0),
    width: MediaQuery.of(context).size.width / 2.5,
    height: MediaQuery.of(context).size.width / 2.5,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 5),
      shape: BoxShape.circle,
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(shop.url),
      ),
    ),
  );
}

Future<void> showEditDialog(
    BuildContext context, bool isAndroid, Shop sh) async {
  if (isAndroid) {
    return await showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            title: "Añadir producto",
            descriptions: "Lorem ipsum",
            text: "ok",
            ancestorContext: context,
            shop: sh,
          );
        });
  } else {
    return await showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
              title: "Editar producto",
              descriptions: "Lorem ipsum",
              text: "ok");
        });
  }
}

Widget getDescription(Shop shop, context) {
  return Center(
    child: Column(
      children: [
        Text(shop.description,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(168, 84, 27, 1),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: TextButton(
              onPressed: () {
                showEditDialog(context, true, shop);
              },
              child: Text(
                "Añadir Producto",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
        ),
      ],
    ),
  );
}

Widget getDescriptionUser(Shop shop, context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
      child: Column(
        children: [
          Text(shop.description,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}

Widget getList(Shop shop) {
  return StreamBuilder(
    stream: db.getShopProducts(shop.id),
    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
      if (snapshot.hasError) {
        return SnapshotError(snapshot.error);
      }
      if (!snapshot.hasData) {
        return Loading();
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 25, bottom: 5),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (_, index) => Center(
              child: shopCellImage(context, snapshot.data[index]),
            ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: snapshot.data.length,
          ),
        ),
      );
    },
  );
}

Widget shopCellImage(BuildContext context, Product p) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductView(
                product: p,
              )));
      print('Cell pressed');
    },
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(p.url.split(',')[0]),
                fit: BoxFit.cover), //NetworkImage(sh.url), fit: BoxFit.cover),
            color: Color(0xFFFFBB65),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 1),
                child: Text(
                  p.name,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
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
