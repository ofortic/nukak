import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/chat.dart';
import 'package:nukak_maku/models/message.dart';
import 'package:nukak_maku/widgets/loading_circle.dart';
import 'package:nukak_maku/widgets/messages_list.dart';
import 'package:nukak_maku/widgets/snerror.dart';
import 'package:provider/provider.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Chat chat = ModalRoute.of(context).settings.arguments;
    final firebaseUser = context.watch<User>();
    final textController = TextEditingController();
    return Scaffold(
        appBar: AppBar(title: Text("chat")),
        body: StreamBuilder(
            stream: db.getMessages(chat.id),
            builder: (context, AsyncSnapshot<List<Message>> snapshot) {
              if (snapshot.hasError) {
                return SnapshotError(snapshot.error);
              }
              if (!snapshot.hasData) {
                return Loading();
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: MessagesList(messages: snapshot.data),
                  ),
                  TextField(
                    controller: textController,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      db.sendMessage(chat.id,
                          Message(textController.text, firebaseUser.uid));
                    },
                  ),
                ],
              );
            }));
  }
}
