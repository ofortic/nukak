import 'package:flutter/material.dart';

import 'package:nukak/view/Sizeconfig.dart';

class CustomAppBar extends PreferredSize {
  final double rating;

  CustomAppBar({@required this.rating});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20), //getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: 40, //getProportionateScreenWidth(40),
              width: 40, //getProportionateScreenWidth(40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Image.asset(
                  "assets/images/logo2nukak.png",
                  height: 15,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "$rating",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset("assets/images/logo2nukak"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
