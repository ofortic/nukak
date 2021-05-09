import 'package:firebase_auth/firebase_auth.dart';
import 'package:nukak/models/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nukak/constants.dart';
import 'text_message.dart';
import 'image_message.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    Widget messageContaint() {
      switch (message.messageType) {
        case 'text':
          return TextMessage(message: message);
        case 'image':
          return ImageMessage(message: message);
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment: message.isSender(firebaseUser.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          messageContaint(),
          if (message.isSender(firebaseUser.uid))
            MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final String status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(String status) {
      switch (status) {
        case 'not_view':
          return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == 'not_sent' ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
