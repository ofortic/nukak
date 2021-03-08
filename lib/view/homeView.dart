import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeView extends StatefulWidget {
  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nukak'),
        backgroundColor: Color(0xFFFF8F00),
      ),
    );
  }
}
