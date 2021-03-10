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
            child: Container(
          height: 200,
          width: 350,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFFFBB65),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        )),
        separatorBuilder: (_, __) => Divider(),
        itemCount: 50,
      ),
    ));
  }
}
