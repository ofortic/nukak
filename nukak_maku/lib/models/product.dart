import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id, userId, shopId;
  String name;
  String description;
  bool active;
  DateTime datetime;

  Product.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        shopId = doc.data()['shopId'],
        name = doc.data()['name'],
        description = doc.data()['description'],
        active = doc.data()['active'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'shopId': shopId,
        'name': name,
        'description': description,
        'active': active,
        'datetime': datetime
      };
  Product(this.name, this.userId, this.shopId, this.description)
      : datetime = DateTime.now(),
        active = true;
}

List<Product> toProductList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Product.fromFirestore(doc)).toList();
}
