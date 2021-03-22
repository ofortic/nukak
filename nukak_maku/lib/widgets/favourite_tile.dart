import 'package:flutter/material.dart';
import 'package:nukak_maku/models/favourite.dart';

class FavouriteTile extends StatelessWidget {
  final Favourite f;
  const FavouriteTile(this.f);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(f.productId),
      title: Text(f.userId),
    );
  }
}