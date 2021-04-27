import 'package:flutter/material.dart';
import 'package:nukak/models/product.dart';

import 'package:nukak/constants.dart';
import 'package:nukak/view/sizeconfig.dart';

class ProductImages extends StatelessWidget {
  ProductImages({
    Key key,
    @required this.urls,
  }) : super(key: key);

  final String urls;
  int selectedImage = 1;

  @override
  Widget build(BuildContext context) {
    List<String> images = urls.split(",");
    return Column(
      children: [
        SizedBox(
          width: 238, //getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: images[selectedImage],
              child: Image.network(images[
                  selectedImage]), //widget.product.images[selectedImage]),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //...List.generate(widget.product.images.length,
            //  (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        selectedImage = index;
      },
      child: AnimatedContainer(
        //duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48, //getProportionateScreenWidth(48),
        width: 48, //getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(
            "assets/images/logo2nukak.png"), //widget.product.images[index]),
      ),
    );
  }
}
