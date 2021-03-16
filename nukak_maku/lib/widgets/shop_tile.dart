import 'package:flutter/material.dart';
import 'package:nukak_maku/models/shop.dart';

class ShopTile extends StatelessWidget {
  final Shop shop;
  const ShopTile(this.shop);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/products', arguments: shop);
        },
        leading: Text(shop.name),
        title: Text(shop.description),
        subtitle: Text(shop.id));
  }
}
