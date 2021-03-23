import 'package:nukak_maku/models/chat.dart';
import 'package:nukak_maku/models/message.dart';

import 'models/product.dart';
import 'models/shop.dart';
import 'models/favourite.dart';
import 'models/report.dart';
import 'models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//SHOPS--------------------------------------------------

//GET ALL THE SHOPS
Stream<List<Shop>> getShops() {
  return FirebaseFirestore.instance
      .collection('shops')
      .snapshots()
      .map(toShopList);
}

// GET ALL OF MY SHOPS
Stream<List<Shop>> getMyShops(String user) {
  return FirebaseFirestore.instance
      .collection('shops')
      .where("userId", isEqualTo: user)
      .snapshots()
      .map(toShopList);
}

// CREATE NEW SHOP
Future<void> sendShop(Shop sh) async {
  await FirebaseFirestore.instance
      .collection('/shops')
      .add(sh.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

//DELETE A SHOP
Future<void> deleteShop(Shop sh) async {
  await FirebaseFirestore.instance.collection('/shops').doc(sh.id).delete();
}
//PRODUCTS--------------------------------------------------

//GET THE PRODUCTS OF A SHOP
Stream<List<Product>> getShopProducts(String shopId) {
  return FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .snapshots()
      .map(toProductList);
}

//CREATE NEW PRODUCT IN A SHOP
Future<void> sendProduct(String shopId, Product pr) async {
  await FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .add(pr.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

//DELETE A PRODUCT
Future<void> deleteProduct(String shopId, Product pr) async {
  await FirebaseFirestore.instance
      .collection('shops/$shopId/products')
      .doc(pr.id)
      .delete();
}
//CHATS--------------------------------------------------

//GET MY CHATS IF IM A USER
Stream<List<Chat>> getMyChats(String user) {
  return FirebaseFirestore.instance
      .collection('chats')
      .where("userId", isEqualTo: user)
      .snapshots()
      .map(toChatList);
}

//GET MY CHATS IF IM A CRAFTSMAN
Stream<List<Chat>> getMyCraftsmanChats(String user) {
  return FirebaseFirestore.instance
      .collection('chats')
      .where("craftsmanId", isEqualTo: user)
      .snapshots()
      .map(toChatList);
}

//CREATE NEW CHAT
Future<void> sendChat(Chat ch) async {
  await FirebaseFirestore.instance
      .collection('/chats')
      .add(ch.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}
//MESSAGES--------------------------------------------------

//GET THE MESSAGES OF A CHAT
Stream<List<Message>> getMessages(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats/$chatId/messages')
      .snapshots()
      .map(toMessageList);
}

//CREATE A NEW MESSAGE IN A CHAT
Future<void> sendMessage(String chatId, Message me) async {
  await FirebaseFirestore.instance
      .collection('chats/$chatId/messages')
      .add(me.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}

//FAVOURITES--------------------------------------------------

//GET MY FAVOURITES
Stream<List<Favourite>> getFavourites(String userId) {
  return FirebaseFirestore.instance
      .collection('users/$userId/favourites')
      .snapshots()
      .map(toFavouriteList);
}

//CREATE A NEW FAVOURITE IN USERS
Future<void> sendFavourite(String userId, Favourite fv) async {
  await FirebaseFirestore.instance
      .collection('users/$userId/favourites')
      .add(fv.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}
//REPORTS--------------------------------------------------

//GET MY REPORTS
Stream<List<Report>> getReports() {
  return FirebaseFirestore.instance
      .collection('/reports')
      .snapshots()
      .map(toReportList);
}

//CREATE A NEW REPORT
Future<void> sendReport(Report re) async {
  await FirebaseFirestore.instance
      .collection('/reports')
      .add(re.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}
//REQUEST--------------------------------------------------

//GET MY REQUEST
Stream<List<Request>> getRequest() {
  return FirebaseFirestore.instance
      .collection('/requests')
      .snapshots()
      .map(toRequestList);
}

//CREATE A NEW REQUEST
Future<void> sendRequest(Request re) async {
  await FirebaseFirestore.instance
      .collection('/requests')
      .add(re.toFirestore())
      .catchError((e) {
    print(e.toString());
  });
}
