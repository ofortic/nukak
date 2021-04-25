import 'package:nukak/constants.dart';
import 'package:flutter/material.dart';

import 'package:nukak/view/chat/screens/messages/components/body.dart';

import '../../../../constants.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
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
            backgroundImage: AssetImage("assets/images/logo2nukak.png"),
          ),
          SizedBox(width: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jairo Quevedo",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Activo hace 3 min",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
