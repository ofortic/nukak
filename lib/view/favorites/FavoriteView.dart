import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.separated(
            itemBuilder: (context, index) => Center(
                  child: favoriteCell(),
                ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: 20),
      ),
    );
  }

  Widget favoriteCell() {
    return GestureDetector(
      onTap: () {
        print('did press favorite cell');
      },
      child: Container(
        height: 150,
        width: 350,
        decoration: BoxDecoration(
            color: Color(0xFF979797),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: SizedBox(
                child: Image.asset('assets/images/logo.png'),
                height: 60,
                width: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                'Tienda_Name',
                style: TextStyle(
                    fontFamily: 'PostNoBillsColombo',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            IconButton(
                icon: Image.asset('assets/images/arrow.png'),
                onPressed: () {
                  print('did Press go to favorite store');
                })
          ],
        ),
      ),
    );
  }
}
