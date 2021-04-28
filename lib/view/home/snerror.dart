import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SnapshotError extends StatelessWidget {
  final FirebaseException error;
  SnapshotError(this.error);
  @override
  Widget build(BuildContext context) {
    print(error.stackTrace);
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          error.toString() + error.stackTrace.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
