import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  String id, userId;
  String name;
  String description;
  bool active;

  Shop.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        name = doc.data()['name'],
        userId = doc.data()['userId'],
        description = doc.data()['description'],
        active = doc.data()['active'];
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'name': name,
        'active': active,
        'description': description
      };
  Shop(this.name, this.userId, this.description) : active = true;
}

List<Shop> toShopList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Shop.fromFirestore(doc)).toList();
}
