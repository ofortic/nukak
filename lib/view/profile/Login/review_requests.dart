import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/favourite.dart';
import 'package:nukak/models/request.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:nukak/view/profile/Login/request_view.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/constants.dart';
import 'package:nukak/view/profile/Login/accept_Decline_Modal.dart';

class MyRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4D5C2),
      appBar: getAppBarHome(context),
      body: getBody(context),
    );
  }

  Widget getAppBarHome(BuildContext context) {
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

  Widget getBody(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return StreamBuilder(
        stream: db.getMyRequest(firebaseUser.uid),
        builder: (context, AsyncSnapshot<List<Request>> snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }
          return Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.separated(
                    itemBuilder: (context, index) => Center(
                      child: requestCell(context, snapshot.data[index]),
                    ),
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snapshot.data.length,
                  )));
        });
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

  Widget requestCell(BuildContext context, Request request) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RequestView(
              request: request,
            ),
          ),
        );
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
            Expanded(child: Text(request.reason)),
            Icon(Icons.arrow_downward_rounded),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}

class AllRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4D5C2),
      appBar: getAppBarHome(context),
      body: getBody(context),
    );
  }

  Widget getAppBarHome(BuildContext context) {
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

  Widget getBody(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return StreamBuilder(
        stream: db.getRequest(),
        builder: (context, AsyncSnapshot<List<Request>> snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }
          if (snapshot.hasData) {
            return Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.separated(
                      itemBuilder: (context, index) => Center(
                        child: requestCell(context, snapshot.data[index]),
                      ),
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: snapshot.data.length,
                    )));
          }
        });
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

  Widget requestCell(BuildContext context, Request request) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RequestView(
              request: request,
            ),
          ),
        );
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
            Expanded(child: Text(request.reason)),
            Icon(Icons.arrow_downward_rounded),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
