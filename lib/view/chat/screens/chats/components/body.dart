import 'package:firebase_auth/firebase_auth.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/models/chat.dart';
import 'package:nukak/view/chat/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:provider/provider.dart';
import 'package:nukak/controller/db.dart' as db;
import 'chat_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUser(firebaseUser),
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

class BodyCraftsman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUser(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.role == 'craftsman') {
              return UserChats(firebaseUser: firebaseUser);
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
    return StreamBuilder(
      stream: db.getMyChats(firebaseUser.uid),
      builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
        if (snapshot.hasError) {
          return SnapshotError(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Loading();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => ChatCard(
                  chat: snapshot.data[index],
                  userId: snapshot.data[index].craftsmanId,
                ),
              ),
            ),
          ],
        );
      },
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
    return StreamBuilder(
      stream: db.getMyCraftsmanChats(firebaseUser.uid),
      builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
        if (snapshot.hasError) {
          return SnapshotError(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Loading();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => ChatCard(
                  chat: snapshot.data[index],
                  userId: snapshot.data[index].userId,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
