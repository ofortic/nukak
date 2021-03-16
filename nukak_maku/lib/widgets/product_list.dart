import 'package:flutter/material.dart';
import 'package:nukak_maku/models/product.dart';
import 'package:nukak_maku/widgets/product_tile.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    @required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductTile(products[index]);
      },
    );
  }
}
