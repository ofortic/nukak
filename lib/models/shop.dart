import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  String id, userId;
  String name;
  String description;
  String url;
  bool active;

  Shop.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        name = doc.data()['name'],
        userId = doc.data()['userId'],
        description = doc.data()['description'],
        url = doc.data()['url'],
        active = doc.data()['active'];
  Shop.fromUniqueFirestore(Map<String, dynamic> doc, String shopId)
      : id = shopId,
        name = doc['name'],
        userId = doc['userId'],
        description = doc['description'],
        url = doc['url'],
        active = doc['active'];
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'name': name,
        'active': active,
        'url': url,
        'description': description
      };
  Shop(this.name, this.userId, this.description, this.url) : active = true;
}

List<Shop> toShopList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Shop.fromFirestore(doc)).toList();
}
