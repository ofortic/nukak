import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/shops.dart';
import 'package:nukak_maku/widgets/shop_tile.dart';

class ShopsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops')),
      body: StreamBuilder(
          stream: db.getShops(),
          builder: (context, AsyncSnapshot<List<Shop>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(backgroundColor: Colors.red),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Shop> shops = snapshot.data;
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
          }),
    );
  }
}
