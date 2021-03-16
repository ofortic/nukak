import 'package:flutter/material.dart';
import 'package:nukak_maku/models/shops.dart';

class ShopTile extends StatelessWidget {
  final Shop shop;
  const ShopTile(this.shop);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(shop.name),
        title: Text(shop.description),
        subtitle: Text(shop.id));
  }
}
