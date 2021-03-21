import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/authentication_service.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/chat.dart';
import 'package:nukak_maku/widgets/chat_list.dart';
import 'package:nukak_maku/widgets/loading_circle.dart';
import 'package:nukak_maku/widgets/snerror.dart';
import 'package:provider/provider.dart';

class ChatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUserRole(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.role == 'user') {
              return UserChats(firebaseUser: firebaseUser);
            } else {
              return CraftsmanChats(firebaseUser: firebaseUser);
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Loading();
        });
  }
}

class UserChats extends StatelessWidget {
  const UserChats({
    Key key,
    @required this.firebaseUser,
  }) : super(key: key);

  final User firebaseUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops')),
      body: StreamBuilder(
          stream: db.getMyChats(firebaseUser.uid),
          builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ChatList(chats: snapshot.data),
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

class CraftsmanChats extends StatelessWidget {
  const CraftsmanChats({
    Key key,
    @required this.firebaseUser,
  }) : super(key: key);

  final User firebaseUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops')),
      body: StreamBuilder(
          stream: db.getMyCraftsmanChats(firebaseUser.uid),
          builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ChatList(chats: snapshot.data),
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
