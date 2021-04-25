import 'package:flutter/material.dart';
import 'package:nukak/view/market/product/components/rounded_icon_btn.dart';
import 'package:nukak/models/Product.dart';

import 'package:nukak/constants.dart';
import 'package:nukak/view/Sizeconfig.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    int selectedColor = 3;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20), //getProportionateScreenWidth(20)),
      child: Row(
        children: [
          //...List.generate(
          //product.colors.length,
          //(index) => ColorDot(                 Esta es la lista de colores de los productos
          //color: product.colors[index],
          //isSelected: index == selectedColor,
          //),
          //),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {},
          ),
          SizedBox(width: 20), //getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    @required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8), //getProportionateScreenWidth(8)),
      height: 40, //getProportionateScreenWidth(40),
      width: 40, //getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
