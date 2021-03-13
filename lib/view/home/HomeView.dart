import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          itemBuilder: (_, index) => Center(
            child: marketCell(),
          ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: 50,
        ),
      ),
    );
  }

  Widget marketCell() {
    return Container(
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
    );
  }
}
