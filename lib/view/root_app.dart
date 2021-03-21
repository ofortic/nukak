import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/view/favorites/FavoriteView.dart';
import 'package:nukak/view/profile/ProfileView.dart';
import 'package:nukak/view/profile/ProfileViewLogin.dart';
import 'home/HomeView.dart';
import 'market/MarketView.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4D5C2),
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> views = [ProfileViewLogin(), HomeView(), FavoriteView()];
    return IndexedStack(
      index: pageIndex,
      children: views,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 1) {
      return AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE4D5C2),
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
      );
    } else if (pageIndex == 0) {
      /* return AppBar(
        backgroundColor: Color(0xFFE4D5C2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    fontFamily: 'PostNoBillsColombo',
                    color: Colors.black,
                    fontSize: 36))
          ],
        ),
      ); */
    } else {
      return AppBar(
        backgroundColor: Color(0xFFE4D5C2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Favoritos",
                style: TextStyle(
                    fontFamily: 'PostNoBillsColombo',
                    color: Colors.black,
                    fontSize: 36))
          ],
        ),
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/icon_profile_activated.png"
          : "assets/images/icon_profile.png",
      pageIndex == 1
          ? "assets/images/icon_home_activated.png"
          : "assets/images/icon_home.png",
      pageIndex == 2
          ? "assets/images/icon_favs_activated.png"
          : "assets/images/icon_favs.png"
    ];
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(color: Color(0xFF979797)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Image.asset(
                  bottomItems[index],
                  width: 25,
                  height: 25,
                ),
              );
            })),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
