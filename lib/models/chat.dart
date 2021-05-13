import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id, craftsmanId, userId, lastMessage, productName, productId;
  DateTime datetime;
  bool active;

  Chat.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        craftsmanId = doc.data()['craftsmanId'],
        userId = doc.data()['userId'],
        lastMessage = doc.data()['lastMessage'],
        productName = doc.data()['productName'],
        productId = doc.data()['productId'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate(),
        active = doc.data()['active'];
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'craftsmanId': craftsmanId,
        'lastMessage': lastMessage,
        'productName': productName,
        'productId': productId,
        'active': active,
        'datetime': datetime
      };
  Chat(this.craftsmanId, this.userId, this.lastMessage, this.productName,
      this.productId)
      : datetime = DateTime.now(),
        active = true;
}

List<Chat> toChatList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Chat.fromFirestore(doc)).toList();
}
