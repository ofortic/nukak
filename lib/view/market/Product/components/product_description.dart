import 'package:flutter/material.dart';
import 'package:nukak/models/product.dart';

import 'package:nukak/constants.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.description,
              maxLines: 3,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20, //getProportionateScreenWidth(20),
            vertical: 10,
          ),
        )
      ],
    );
  }
}
