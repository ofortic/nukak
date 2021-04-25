import 'package:flutter/material.dart';
import 'package:nukak/models/Product.dart';

import 'package:nukak/constants.dart';
import 'package:nukak/view/sizeconfig.dart';

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
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20), //getProportionateScreenWidth(20)),
          child: Text(
            "Título del producto", //product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(15), //getProportionateScreenWidth(15)),
            width: 64, //getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color:
                  //product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                  kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Image.asset(
              "assets/images/logo2nukak.png",
              color:
                  //product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                  kPrimaryColor,
              height: 16, //getProportionateScreenWidth(16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20, //getProportionateScreenWidth(20),
            right: 64, //getProportionateScreenWidth(64),
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20, //getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Ver más detalles",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
