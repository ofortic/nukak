import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/models/chat.dart';
import 'package:nukak/constants.dart';
import 'package:nukak/view/chat/screens/messages/message_screen.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key key, @required this.chat, @required this.userId})
      : super(key: key);

  final Chat chat;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUserChat(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SnapshotError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(
                    chat: this.chat,
                    name: snapshot.data.name,
                    url: snapshot.data.url,
                    productName: chat.productName,
                    uid: firebaseUser.uid,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding * 0.75),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(snapshot.data.url),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 3),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.name + ' - ' + chat.productName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          Opacity(
                            opacity: 0.64,
                            child: Text(
                              chat.lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.64,
                    child: Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(chat.datetime)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
