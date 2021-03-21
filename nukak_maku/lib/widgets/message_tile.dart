import 'package:flutter/material.dart';
import 'package:nukak_maku/models/message.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  const MessageTile(this.message);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message.text),
      subtitle: Text(message.datetime.toString()),
    );
  }
}
