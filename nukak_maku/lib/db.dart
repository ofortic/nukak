import 'package:nukak_maku/models/chat.dart';
import 'package:nukak_maku/models/message.dart';

import 'models/product.dart';
import 'models/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Shop>> getShops() {
  return FirebaseFirestore.instance
      .collection('shops')
      .snapshots()
      .map(toShopList);
}

Stream<List<Shop>> getMyShops(String user) {
  return FirebaseFirestore.instance
      .collection('shops')
      .where("userId", isEqualTo: user)
      .snapshots()
      .map(toShopList);
}

Stream<List<Chat>> getMyChats(String user) {
  return FirebaseFirestore.instance
      .collection('chats')
      .where("userId", isEqualTo: user)
      .snapshots()
      .map(toChatList);
}

Stream<List<Chat>> getMyCraftsmanChats(String user) {
  return FirebaseFirestore.instance
      .collection('chats')
      .where("craftsmanId", isEqualTo: user)
      .snapshots()
      .map(toChatList);
}

Stream<List<Message>> getMessages(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats/$chatId/messages')
      .snapshots()
      .map(toMessageList);
}

Stream<List<Product>> getShopProducts(String shopId) {
  return FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .snapshots()
      .map(toProductList);
}

Stream<List<Product>> getMyShopProducts(String shopId) {
  return FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .snapshots()
      .map(toProductList);
}

Future<void> sendChat(Chat ch) async {
  await FirebaseFirestore.instance
      .collection('/chats')
      .add(ch.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

Future<void> sendMessage(String chatId, Message me) async {
  await FirebaseFirestore.instance
      .collection('chats/$chatId/messages')
      .add(me.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

Future<void> sendProduct(String shopId, Product pr) async {
  await FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .add(pr.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

Future<void> sendShop(Shop sh) async {
  await FirebaseFirestore.instance
      .collection('/shops')
      .add(sh.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

Future<void> deleteProduct(String shopId, Product pr) async {
  await FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .doc(pr.id)
      .delete();
}

Future<void> deleteShop(Shop sh) async {
  await FirebaseFirestore.instance.collection('/shops').doc(sh.id).delete();
}
