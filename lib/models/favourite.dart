import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
  String id, userId, shopId;
  DateTime datetime;

  Favourite.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        shopId = doc.data()['shopId'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() =>
      {'userId': userId, 'shopId': shopId, 'datetime': datetime};
  Favourite(this.userId, this.shopId) : datetime = DateTime.now();
}

List<Favourite> toFavouriteList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Favourite.fromFirestore(doc)).toList();
}
