import 'package:flutter/material.dart';
import 'package:nukak_maku/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      title: Text(product.name),
      subtitle: Text(product.datetime.toString()),
    );
  }
}
