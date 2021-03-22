import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/authentication_service.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/request.dart';
import 'package:nukak_maku/widgets/request_list.dart';
import 'package:nukak_maku/widgets/loading_circle.dart';
import 'package:nukak_maku/widgets/snerror.dart';
import 'package:provider/provider.dart';

class RequestsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUserRole(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.role == 'admin') {
              return URequests(firebaseUser: firebaseUser);
            } else {
              return Text('no');
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Loading();
        });
  }
}

class URequests extends StatelessWidget {
  const URequests({
    Key key,
    @required this.firebaseUser,
  }) : super(key: key);

  final User firebaseUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops')),
      body: StreamBuilder(
          stream: db.getRequest(),
          builder: (context, AsyncSnapshot<List<Request>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: RequestList(requests: snapshot.data),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () =>
                      context.read<AuthenticationService>().signOut(),
                ),
              ],
            );
          }),
    );
  }
}


