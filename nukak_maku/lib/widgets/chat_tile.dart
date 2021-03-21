import 'package:flutter/material.dart';
import 'package:nukak_maku/models/chat.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile(this.chat);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/messages', arguments: chat);
      },
      leading: Text(chat.craftsmanId),
      title: Text(chat.userId),
    );
  }
}
