import 'package:flutter/material.dart';
import 'package:nukak/models/product.dart';

import 'package:nukak/constants.dart';

class ProductImages extends StatelessWidget {
  ProductImages({
    Key key,
    @required this.urls,
  }) : super(key: key);

  final String urls;
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    List<String> images = urls.split(",");
    int selectedImage = images.length - 1;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.3,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: images[selectedImage],
              child: Image.network(images[selectedImage]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(images.length - 1,
                (index) => buildSmallProductPreview(images, index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(List<String> images, int index) {
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
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(images[index]), //widget.product.images[index]),
      ),
    );
  }
}
