import 'package:flutter/material.dart';
import 'package:nukak_maku/views/create_product.dart';
import 'package:nukak_maku/views/create_shop.dart';
import 'package:nukak_maku/views/product_view.dart';
import 'package:nukak_maku/views/products_view.dart';
import 'package:nukak_maku/views/shop_view.dart';

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
        '/': (_) => ShopsView(),
        '/products': (_) => ProductsView(),
        '/product': (_) => ProductView(),
        '/create_product': (_) => CreateProductView(),
        '/create_shop': (_) => CreateShopView(),
      },
    );
  }
}
