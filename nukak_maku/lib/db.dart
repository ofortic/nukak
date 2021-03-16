import 'models/product.dart';
import 'models/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Shop>> getShops() {
  return Firestore.instance.collection('shops').snapshots().map(toShopList);
}

Stream<List<Product>> getShopProducts(String shopId) {
  return Firestore.instance
      .collection('shops/$shopId/products')
      .snapshots()
      .map(toProductList);
}

Future<void> sendProduct(String shopId, Product pr) async {
  await Firestore.instance
      .collection('shops/$shopId/products')
      .add(pr.toFirestore());
}

Future<void> sendShop(Shop sh) async {
  await Firestore.instance.collection('/shops').add(sh.toFirestore());
}

Future<void> deleteProduct(String shopId, Product pr) async {
  await Firestore.instance
      .collection('shops/$shopId/products')
      .document(pr.id)
      .delete();
}

Future<void> deleteShop(Shop sh) async {
  await Firestore.instance.collection('/shops').document(sh.id).delete();
}
