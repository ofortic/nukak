import 'package:flutter/material.dart';
import 'package:nukak_maku/models/shop.dart';

import 'shop_tile.dart';

class ShopList extends StatelessWidget {
  const ShopList({
    @required this.shops,
  });

  final List<Shop> shops;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: shops.length,
      itemBuilder: (context, index) {
        return ShopTile(shops[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          indent: 75,
          endIndent: 15,
        );
      },
    );
  }
}
