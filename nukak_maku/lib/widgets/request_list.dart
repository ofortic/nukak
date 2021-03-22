import 'package:flutter/material.dart';
import 'package:nukak_maku/models/request.dart';
import 'package:nukak_maku/widgets/request_tile.dart';

class RequestList extends StatelessWidget {
  const RequestList({
    @required this.requests,
  });

  final List<Request> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return RequestTile(requests[index]);
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
