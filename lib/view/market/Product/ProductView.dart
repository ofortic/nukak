import 'package:flutter/material.dart';

import 'package:nukak/models/product.dart';
import 'components/body.dart';

class ProductView extends StatelessWidget {
  static String routeName = "/details";
  final Product product;
  ProductView({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(product: product),
    );
  }
}
