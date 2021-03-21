import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels <= 200)
        setState(() => _physics = BouncingScrollPhysics());
      else
        setState(() => _physics = BouncingScrollPhysics());
    });
  }

  @override
  Widget build(BuildContext context) {
    return getBodyTest();
  }

  Widget getBody() {
    return Center(
      child: Text(
        "Home View",
        style: TextStyle(
            fontFamily: 'PostNoBillsColombo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }

  Widget getBodyTest() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        child: ListView.separated(
          controller: _controller,
          physics: _physics,
          itemBuilder: (_, index) => Center(
            child: marketCell(),
          ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: 5,
        ),
      ),
    );
  }

  Widget marketCell() {
    return GestureDetector(
      onTap: () {
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
