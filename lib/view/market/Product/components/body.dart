import 'package:flutter/material.dart';
import 'package:nukak/view/market/Product/components/default_buttom.dart';
import 'package:nukak/models/product.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  Body({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover),
      ),
      child: ListView(
        children: [
          Container(
            child: ProductImages(urls: product.url),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    children: [
                      TopRoundedContainer(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.07,
                            right: MediaQuery.of(context).size.width * 0.07,
                            bottom: 0,
                            top: 0,
                          ),
                          child: DefaultButton(
                            text: "Chatear con el vendedor",
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
      ),
    );
  }
}
