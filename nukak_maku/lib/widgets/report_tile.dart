import 'package:flutter/material.dart';
import 'package:nukak_maku/models/report.dart';

class ReportTile extends StatelessWidget {
  final Report f;
  const ReportTile(this.f);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(f.reason),
      title: Text(f.userId),
    );
  }
}