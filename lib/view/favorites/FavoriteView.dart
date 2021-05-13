import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/favourite.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import '../../constants.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4D5C2),
      appBar: getAppBarHome(),
      body: getBody(),
    );
  }

  Widget getAppBarHome() {
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
                  color: kFavoriteCellColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data.url),
                              fit: BoxFit.cover)),
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
                ],
              ),
            ),
          );
        });
  }
}
