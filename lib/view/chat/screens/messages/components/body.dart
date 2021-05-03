import 'package:nukak/constants.dart';
import 'package:nukak/models/chat.dart';
import 'package:nukak/models/message.dart';
import 'package:flutter/material.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'chat_input_field.dart';
import 'message_box.dart';

class Body extends StatelessWidget {
  const Body({Key key, @required this.chat, @required this.uid})
      : super(key: key);

  final Chat chat;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.getMessages(chat.id),
      builder: (context, AsyncSnapshot<List<Message>> snapshot) {
        if (snapshot.hasError) {
          return SnapshotError(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Loading();
        }
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      MessageBox(message: snapshot.data[index]),
                ),
              ),
            ),
            ChatInputField(),
          ],
        );
      },
    );
  }
}
