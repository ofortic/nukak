import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id, craftsmanId, userId;
  DateTime datetime;
  bool active;

  Chat.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        craftsmanId = doc.data()['craftsmanId'],
        userId = doc.data()['userId'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate(),
        active = doc.data()['active'];
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'craftsmanId': craftsmanId,
        'active': active,
        'datetime': datetime
      };
  Chat(this.craftsmanId, this.userId)
      : datetime = DateTime.now(),
        active = true;
}

List<Chat> toChatList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Chat.fromFirestore(doc)).toList();
}
