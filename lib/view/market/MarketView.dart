import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarketView extends StatefulWidget {
  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: getBodyTest(), color: Colors.white);
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

Widget getBodyTest() {
  return Column(
    children: <Widget>[getProfilePhoto(), getDescription(), getList()],
  );
}

Widget getProfilePhoto() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 25, bottom: 5),
      child: _buildCircle(),
    ),
  );
}

Widget getDescription() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 25, bottom: 5),
      child: Text(
          "Esta es la descipción de la tienda que obtendrá toda la info, contacto, ubicación y demás",
          style: TextStyle(
              fontFamily: 'PostNoBillsColombo',
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: TextAlign.center),
    ),
  );
}

Widget getList() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 25, bottom: 5),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (_, index) => Center(
          child: marketCell(),
        ),
        separatorBuilder: (_, __) => Divider(),
        itemCount: 10,
      ),
    ),
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

Widget marketCell() {
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
