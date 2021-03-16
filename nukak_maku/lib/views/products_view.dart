import 'package:flutter/material.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/product.dart';
import 'package:nukak_maku/models/shop.dart';
import 'package:nukak_maku/widgets/loading_circle.dart';
import 'package:nukak_maku/widgets/product_list.dart';
import 'package:nukak_maku/widgets/snerror.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Shop shop = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text(shop.name)),
        body: StreamBuilder(
            stream: db.getShopProducts(shop.id),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasError) {
                return SnapshotError(snapshot.error);
              }
              if (!snapshot.hasData) {
                return Loading();
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ProductList(products: snapshot.data),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/create_product', arguments: shop),
                  ),
                ],
              );
            }));
  }
}
