import 'package:flutter/material.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/shop.dart';
import 'package:nukak_maku/widgets/loading_circle.dart';
import 'package:nukak_maku/widgets/shop_list.dart';
import 'package:nukak_maku/widgets/snerror.dart';

class ShopsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops')),
      body: StreamBuilder(
          stream: db.getShops(),
          builder: (context, AsyncSnapshot<List<Shop>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ShopList(shops: snapshot.data),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/create_shop'),
                ),
              ],
            );
          }),
    );
  }
}
