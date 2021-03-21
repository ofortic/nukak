import 'package:flutter/material.dart';
import 'package:nukak_maku/models/chat.dart';
import 'package:nukak_maku/widgets/chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    @required this.chats,
  });

  final List<Chat> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatTile(chats[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          indent: 75,
          endIndent: 15,
        );
      },
    );
  }
}
