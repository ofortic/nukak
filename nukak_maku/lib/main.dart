import 'package:flutter/material.dart';
import 'package:nukak_maku/views/shops_view.dart';

void main() => runApp(NukakMakuApp());

class NukakMakuApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nukak Maku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ShopsView(),
      },
    );
  }
}
