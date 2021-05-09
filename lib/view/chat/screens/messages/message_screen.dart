import 'package:nukak/constants.dart';
import 'package:flutter/material.dart';
import 'package:nukak/models/chat.dart';

import 'package:nukak/view/chat/screens/messages/components/body.dart';

import '../../../../constants.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen(
      {Key key,
      @required this.chat,
      @required this.name,
      @required this.url,
      @required this.productName,
      @required this.uid})
      : super(key: key);

  final Chat chat;
  final String name;
  final String url;
  final String uid;
  final String productName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(
        chat: this.chat,
        uid: this.uid,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: NetworkImage(url),
          ),
          SizedBox(width: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ' + name + ' - ' + productName,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
