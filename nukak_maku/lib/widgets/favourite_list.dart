import 'package:flutter/material.dart';
import 'package:nukak_maku/models/favourite.dart';
import 'package:nukak_maku/widgets/favourite_tile.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({
    @required this.favourites,
  });

  final List<Favourite> favourites;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        return FavouriteTile(favourites[index]);
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
