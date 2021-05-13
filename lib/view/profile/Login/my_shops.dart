import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/models/favourite.dart';
import 'package:nukak/models/shop.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants.dart';

class HomeViewCraftsman extends StatefulWidget {
  @override
  _HomeViewCraftsmanState createState() => _HomeViewCraftsmanState();
}

class _HomeViewCraftsmanState extends State<HomeViewCraftsman> {
  var _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();
  bool _showAppbar = true;
  bool isScrollingDown = false;
  List<String> favIcon = [
    'assets/images/removeFavIcon.png',
    'assets/images/addFavIcon.png'
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels <= 56) {
        setState(() => _physics = BouncingScrollPhysics());
      } else {
        setState(() => _physics = BouncingScrollPhysics());
      }
    });
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
        backgroundColor: Color(0xFFE4D5C2),
        appBar: getAppBarHome(),
        body: StreamBuilder(
          stream: db.getMyShops(firebaseUser.uid),
          builder: (context, AsyncSnapshot<List<Shop>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return getBody(snapshot.data, firebaseUser.uid);
          },
        ));
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

  Widget getBody(List<Shop> shops, String uid) {
    print(shops.length);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
        child: ListView.separated(
          itemCount: shops.length,
          controller: _controller,
          physics: _physics,
          itemBuilder: (context, index) => Center(
            child: shopCellImage(shops[index], uid),
          ),
          separatorBuilder: (_, __) => Divider(),
        ),
      ),
    );
  }

  getIcon(Shop sh, String uid) {
    var sw = true;
    db
        .isFavourite(uid, sh.id)
        .then((value) => {print(value), sw = value})
        .catchError((onErrror) {});
    if (sw) {
      return 0;
    }
    return 1;
  }

  Widget shopCellImage(Shop sh, String uid) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MarketView(
                  shop: sh,
                )));
        print('Cell pressed');
      },
      child: Column(
        children: [
          Container(
            height: 280,
            width: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(sh.url), fit: BoxFit.cover),
                color: Color(0xFFFFBB65),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
          Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              children: [
                SizedBox(
                  height: 1,
                  width: 30,
                ),
                Text(
                  sh.name,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Spacer(),
                IconButton(
                    icon: Image.asset(favIcon[getIcon(sh, uid)]),
                    onPressed: () {
                      db
                          .isFavourite(uid, sh.id)
                          .then((value) => {
                                //print(value),
                                if (value)
                                  {db.deleteFavorurite(uid, sh.id)}
                                else
                                  {db.sendFavourite(uid, Favourite(uid, sh.id))}
                              })
                          .catchError((onErrror) {
                        print('hello');
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
