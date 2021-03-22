import 'package:flutter/material.dart';
import 'package:nukak_maku/models/report.dart';
import 'package:nukak_maku/widgets/report_tile.dart';

class ReportList extends StatelessWidget {
  const ReportList({
    @required this.reports,
  });

  final List<Report> reports;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return ReportTile(reports[index]);
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
