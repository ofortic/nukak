import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileViewEdit extends StatefulWidget {
  @override
  _ProfileViewEditState createState() => _ProfileViewEditState();
}

class _ProfileViewEditState extends State<ProfileViewEdit> {
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
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
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textfield(
                      hintText: "Nombres y Apellidos",
                    ),
                    textfield(
                      hintText: "Ciudad",
                    ),
                    textfield(
                      hintText: "Correo electrónico",
                    ),
                    textfield(
                      hintText: "Teléfono de contacto",
                    ),
                    textfield(
                      hintText: "Fecha de nacimiento",
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {},
                        color: new Color.fromRGBO(111, 31, 10, 0.9),
                        child: Center(
                          child: Text(
                            "Actualizar",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                  "Editar perfil",
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/logo2nukak.png"),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 270, left: 184)),
          CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = new Color.fromRGBO(111, 31, 10, 0.9);
    Path path = Path()
      ..relativeLineTo(0, 30)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 30)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
