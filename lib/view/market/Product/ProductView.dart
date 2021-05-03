import 'package:flutter/material.dart';

import 'package:nukak/models/product.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'components/body.dart';

class ProductView extends StatelessWidget {
  static String routeName = "/details";
  final Product product;
  ProductView({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 215, 171, 1),
      appBar: getAppBarHome(context),
      body: Body(product: product),
    );
  }
}
