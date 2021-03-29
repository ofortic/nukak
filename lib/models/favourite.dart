import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
  String id, userId, productId;
  DateTime datetime;

  Favourite.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        productId = doc.data()['productId'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'productId': productId,
        'datetime': datetime
      };
  Favourite( this.userId, this.productId)
      : datetime = DateTime.now();
}

List<Favourite> toFavouriteList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Favourite.fromFirestore(doc)).toList();
}
