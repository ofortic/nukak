import 'package:flutter/material.dart';
import 'package:nukak/view/market/MarketView.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarHome(context),
      body: Body(),
    );
  }
}
