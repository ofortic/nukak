import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id, userId;
  String name;
  String description;
  DateTime datetime;

  Product.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'],
        description = doc.data['description'],
        datetime = (doc.data['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() =>
      {'name': name, 'description': description, 'datetime': datetime};
  Product(this.name, this.description) : datetime = DateTime.now();
}

List<Product> toProductList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.documents;
  return docs.map((doc) => Product.fromFirestore(doc)).toList();
}
