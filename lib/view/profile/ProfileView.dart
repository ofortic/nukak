import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Widget textfield({@required String hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUser(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: new Color.fromRGBO(111, 31, 10, 0.9),
                ),
              ),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 280,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textfield(
                              hintText: snapshot.data.city,
                            ),
                            textfield(
                              hintText: snapshot.data.email,
                            ),
                            textfield(
                              hintText: snapshot.data.tel,
                            ),
                            textfield(
                              hintText: snapshot.data.date_of_birth,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomPaint(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          snapshot.data.name,
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data.url),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Loading();
        });
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = new Color.fromRGBO(111, 31, 10, 0.9);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
