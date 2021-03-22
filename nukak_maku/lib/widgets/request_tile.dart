import 'package:flutter/material.dart';
import 'package:nukak_maku/models/request.dart';

class RequestTile extends StatelessWidget {
  final Request f;
  const RequestTile(this.f);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(f.reason),
      title: Text(f.userId),
    );
  }
}