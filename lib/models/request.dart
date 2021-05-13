import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String id, userId, reason;
  bool approved;
  bool checked;
  DateTime datetime;
  String url;

  Request.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        reason = doc.data()['reason'],
        approved = doc.data()['approved'],
        checked = doc.data()['checked'],
        url = doc.data()['url'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'reason': reason,
        'approved': approved,
        'checked': checked,
        'datetime': datetime,
        'url': url,
      };
  Request(this.userId, this.reason, this.url)
      : datetime = DateTime.now(),
        approved = false,
        checked = false;
}

List<Request> toRequestList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Request.fromFirestore(doc)).toList();
}
