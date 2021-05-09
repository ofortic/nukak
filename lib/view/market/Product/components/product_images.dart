import 'package:flutter/material.dart';

import 'package:nukak/constants.dart';

class ProductImages extends StatefulWidget {
  ProductImages({
    Key key,
    @required this.urls,
  }) : super(key: key);

  final String urls;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.urls.split(",");

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(images[selectedImage]),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                images.length,
                (index) => buildSmallProductPreview(images, index),
              ),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(List<String> images, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48, //getProportionateScreenWidth(48),
        width: 48, //getProportionateScreenWidth(48),
        duration: Duration(seconds: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(images[index]),
      ),
    );
  }
}
