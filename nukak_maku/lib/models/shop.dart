import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  String id, userId;
  String name;
  String description;

  Shop.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'],
        description = doc.data['description'];
  Map<String, dynamic> toFirestore() =>
      {'name': name, 'description': description};
  Shop(this.name, this.description);
}

List<Shop> toShopList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.documents;
  return docs.map((doc) => Shop.fromFirestore(doc)).toList();
}
