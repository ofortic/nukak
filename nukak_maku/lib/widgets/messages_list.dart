import 'package:flutter/material.dart';
import 'package:nukak_maku/models/message.dart';
import 'package:nukak_maku/widgets/message_tile.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    @required this.messages,
  });

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageTile(messages[index]);
      },
    );
  }
}
