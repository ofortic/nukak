import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/favourite.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/constants.dart';
import 'package:nukak/view/profile/Login/accept_Decline_Modal.dart';

class ReviewRequests extends StatefulWidget {
  @override
  _ReviewRequestsState createState() => _ReviewRequestsState();
}

class _ReviewRequestsState extends State<ReviewRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4D5C2),
      appBar: getAppBarHome(),
      body: getBody(),
    );
  }

  Widget getAppBarHome() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logonukak.png',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * 0.09,
            color: Colors.white60,
          ),
          Container(padding: const EdgeInsets.all(8.0))
        ],
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
    );
  }

  Widget getBody() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              itemBuilder: (context, index) => Center(
                child: requestCell(),
              ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: 10,
            )));
  }

  Future<void> showAcceptDeclineModal(
      BuildContext context, bool isAndroid) async {
    if (isAndroid) {
      return await showDialog(
          context: context,
          builder: (context) {
            return AceptDeclineModal(
                title: "Aceptar o Rechazar",
                descriptions: "Aqui va la descripcion de la solicitud",
                text: "ok");
          });
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return AceptDeclineModal(
                title: "Aceptar o Rechazar",
                descriptions: "Aqui va la descripcion de la solicitud",
                text: "ok");
          });
    }
  }

  Widget requestCell() {
    return GestureDetector(
      onTap: () {
        showAcceptDeclineModal(context, true);
        print('Cell pressed');
      },
      onLongPress: () {
        print('Long pressed');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
            color: kPrimaryColorAlpha,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          children: [
            SizedBox(width: 10),
            Expanded(child: Text('[nombre del solicitante]')),
            Icon(Icons.arrow_downward_rounded),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
