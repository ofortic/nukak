import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUser(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          } else {
            if (snapshot.data.role == 'craftsman') {
              return Scaffold(
                  appBar: getAppBarHome(context), body: BodyCraftsman());
            } else if (snapshot.data.role == 'user') {
              return Scaffold(appBar: getAppBarHome(context), body: BodyUser());
            } else {
              return Scaffold(
                  appBar: getAppBarHome(context), body: BodyAdmin());
            }
          }
        });
  }
}
