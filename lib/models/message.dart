import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id, userId;
  String text;
  DateTime datetime;

  Message.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        text = doc.data()['text'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() =>
      {'userId': userId, 'text': text, 'datetime': datetime};
  Message(this.text, this.userId) : datetime = DateTime.now();
}

List<Message> toMessageList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Message.fromFirestore(doc)).toList();
}
