import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/models/shop.dart';
import 'package:nukak/view/chat/screens/chats/chats_screen.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:nukak/view/market/Product/ProductView.dart';

import '../market/Product/ProductView.dart';
import 'loading_circle.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    // TODO: implement initState
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
          print('Scrolling down');
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          print('Scrolling up');
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
    return Scaffold(
        backgroundColor: Color(0xFFE4D5C2),
        appBar: animatedAppbar(),
        body: StreamBuilder(
          stream: db.getShops(),
          builder: (context, AsyncSnapshot<List<Shop>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return getBody(snapshot.data);
          },
        ));
  }

  Widget animatedAppbar() {
    return PreferredSize(
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFfc8300),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Nukak",
                style: TextStyle(
                    fontFamily: 'PostBillsColombo',
                    color: Colors.black,
                    fontSize: 36),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        ),
        preferredSize: _showAppbar ? Size.fromHeight(56) : Size.fromHeight(0));
  }

  Widget getAppBarHome() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFFfc8300),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Nukak",
              style: TextStyle(
                  fontFamily: 'PostNoBillsColombo',
                  color: Colors.black,
                  fontSize: 36))
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
    );
  }

  Widget getBody(List<Shop> shops) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
        child: ListView.separated(
          itemCount: shops.length,
          controller: _controller,
          physics: _physics,
          itemBuilder: (context, index) => Center(
            child: shopCell(shops[index]),
          ),
          separatorBuilder: (_, __) => Divider(),
        ),
      ),
    );
  }

  Widget shopCell(Shop sh) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MarketView(
                  shop: sh,
                )));
        print('Cell pressed');
      },
      child: Container(
        height: 200,
        width: 350,
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Text(sh.description),
                  height: 130,
                  width: 220,
                  decoration: BoxDecoration(
                      color: Color(0xFF0CD1E5),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20))),
                ),
                Container(
                  height: 70,
                  width: 220,
                  decoration: BoxDecoration(
                      color: Color(0xFF5CE794),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 150, top: 0),
                    child: Center(
                      child: IconButton(
                        icon: Image.asset('assets/images/icon_favs.png'),
                        onPressed: () {
                          print('IconFavsPressed');
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color(0xFF979797),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20))),
                ),
                Container(
                  height: 100,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFBB65),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
