import 'package:flutter/material.dart';

class SnapshotError extends StatelessWidget {
  final Error error;
  SnapshotError(this.error);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
