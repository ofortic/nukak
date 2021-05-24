import 'package:firebase_auth/firebase_auth.dart';
import 'package:nukak/models/message.dart';
import 'package:nukak/view/chat/models/chatmessageexample.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nukak/constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor
            .withOpacity(message.isSender(firebaseUser.uid) ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Wrap(
        children: [
          Text(
            message.text,
            style: TextStyle(
              color: message.isSender(firebaseUser.uid)
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ],
      ),
    );
  }
}
