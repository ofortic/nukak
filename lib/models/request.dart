import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String id, userId, reason;
  bool approved;
  DateTime datetime;
  String url;

  Request.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        reason = doc.data()['reason'],
        approved = doc.data()['approved'],
        url = doc.data()['url'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'reason': reason,
        'approved': approved,
        'datetime': datetime,
        'url': url,
      };
  Request(this.userId, this.reason)
      : datetime = DateTime.now(),
        url =
            "https://firebasestorage.googleapis.com/v0/b/nukak-maku.appspot.com/o/uploads%2Fdownload%20(1).png?alt=media&token=fe93e733-8a5a-4374-9587-3a0065129eea",
        approved = false;
}

List<Request> toRequestList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Request.fromFirestore(doc)).toList();
}
