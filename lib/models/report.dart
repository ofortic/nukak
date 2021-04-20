import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id, userId, reportedId, reason;
  bool checked;
  DateTime datetime;

  Report.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        reportedId = doc.data()['reportedId'],
        reason = doc.data()['reason'],
        checked = doc.data()['checked'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'reportedId': reportedId,
        'reason': reason,
        'checked': checked,
        'datetime': datetime
      };
  Report( this.userId, this.reportedId, this.reason)
      : datetime = DateTime.now(), checked=false;
}

List<Report> toReportList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Report.fromFirestore(doc)).toList();
}