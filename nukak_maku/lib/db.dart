import 'models/shops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Shop>> getShops() {
  return Firestore.instance.collection('shops').snapshots().map(toShopList);
}
