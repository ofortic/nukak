import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/favorites/FavoriteView.dart';
import 'package:nukak/view/profile/profile.dart';
import 'favorites/FavoriteView.dart';
import 'home/HomeView.dart';
import 'package:provider/provider.dart';

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
    List<Widget> views = [ProfilePage(), HomeView(), FavoriteView()];
    return IndexedStack(
      index: pageIndex,
      children: views,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 1) {
      return null;
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
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xFF979797),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  if (index == 2) {
                    selectedTab(index);
                  } else if (index == 0) {
                    selectedTab(index);
                    print('Cell pressed');
                  } else if (index == 1) {
                    selectedTab(index);
                  }
                },
                child: Image.asset(
                  bottomItems[index],
                  width: 70,
                  height: 70,
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
