import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/product.dart';
import 'package:nukak/models/shop.dart';

import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';

class MarketView extends StatelessWidget {
  final Shop shop;

  // In the constructor, require a Todo.
  MarketView({Key key, @required this.shop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(child: getBodyTest(context, shop), color: Colors.white);
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget getBodyTest(BuildContext context, Shop shop) {
  return Column(
    children: <Widget>[
      getAppBarHome(),
      getProfilePhoto(context, shop),
      getDescription(shop),
      getList(shop)
    ],
  );
}

Widget getProfilePhoto(BuildContext context, Shop shop) {
  return Container(
    padding: EdgeInsets.all(10.0),
    width: MediaQuery.of(context).size.width / 2.5,
    height: MediaQuery.of(context).size.width / 2.5,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 5),
      shape: BoxShape.circle,
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(shop.url),
      ),
    ),
  );
}

Widget getDescription(Shop shop) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 25, bottom: 5),
      child: Text(shop.description,
          style: TextStyle(
              fontFamily: 'PostNoBillsColombo',
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: TextAlign.center),
    ),
  );
}

Widget getList(Shop shop) {
  return StreamBuilder(
    stream: db.getShopProducts(shop.id),
    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
      if (snapshot.hasError) {
        return SnapshotError(snapshot.error);
      }
      if (!snapshot.hasData) {
        return Loading();
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 25, bottom: 5),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (_, index) => Center(
              child: marketCell(snapshot.data[index]),
            ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: snapshot.data.length,
          ),
        ),
      );
    },
  );
}

Widget _buildCircle() {
  return SizedBox(
    width: 120,
    height: 120,
    child: CustomPaint(
      painter: CirclePainter(),
    ),
  );
}

Widget marketCell(Product p) {
  return Container(
    height: 200,
    width: 350,
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 130,
              width: 220,
              decoration: BoxDecoration(
                  color: Color(0xFF0CD1E5),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Text(
                p.name,
                style: TextStyle(
                    fontFamily: 'PostNoBillsColombo',
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              height: 70,
              width: 220,
              decoration: BoxDecoration(
                  color: Color(0xFF5CE794),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20))),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 130,
              decoration: BoxDecoration(
                  color: Color(0xFF979797),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(20))),
            ),
            Container(
              height: 100,
              width: 130,
              decoration: BoxDecoration(
                  color: Color(0xFFFFBB65),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20))),
            )
          ],
        )
      ],
    ),
  );
}

Widget getAppBarHome() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFfc8300),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Nukak",
            style: TextStyle(
                fontFamily: 'PostNoBillsColombo',
                color: Colors.black,
                fontSize: 36))
      ],
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
  );
}
