import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/favourite.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    final firebaseUser = context.watch<User>();
    return StreamBuilder(
        stream: db.getFavourites(firebaseUser.uid),
        builder: (context, AsyncSnapshot<List<Favourite>> snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }
          return Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
                itemBuilder: (context, index) => Center(
                      child: favoriteCell(snapshot.data[index].shopId),
                    ),
                separatorBuilder: (_, __) => Divider(),
                itemCount: snapshot.data.length),
          ));
        });
  }

  Widget favoriteCell(String shopId) {
    return FutureBuilder(
        future: db.getShop(shopId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }
          print(snapshot.data);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MarketView(
                        shop: snapshot.data,
                      )));
              print('did press favorite cell');
            },
            child: Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                  color: Color(0xFF979797),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30),
                    child: SizedBox(
                      child: Image.network(snapshot.data.url),
                      height: 60,
                      width: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      snapshot.data.name,
                      style: TextStyle(
                          fontFamily: 'PostNoBillsColombo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  IconButton(
                      icon: Image.asset('assets/images/arrow.png'),
                      onPressed: () {
                        print('did Press go to favorite store');
                      })
                ],
              ),
            ),
          );
        });
  }
}
