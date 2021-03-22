import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String id, userId, reason;
  bool approved;
  DateTime datetime;

  Request.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        reason = doc.data()['reason'],
        approved = doc.data()['approved'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'reason': reason,
        'approved': approved,
        'datetime': datetime
      };
  Request( this.userId, this.reason)
      : datetime = DateTime.now(), approved=false;
}

List<Request> toRequestList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Request.fromFirestore(doc)).toList();
}