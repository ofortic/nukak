import 'package:flutter/material.dart';
import 'package:nukak/view/market/Product/components/default_buttom.dart';
import 'package:nukak/models/Product.dart';
import 'package:nukak/view/SizeConfig.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15, //SizeConfig.screenWidth * 0.15,
                          right: 15, //SizeConfig.screenWidth * 0.15,
                          bottom: 40, //getProportionateScreenWidth(40),
                          top: 15, //getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Añadir al carrito",
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
