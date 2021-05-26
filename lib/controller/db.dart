import 'package:nukak/models/chat.dart';
import 'package:nukak/models/message.dart';

import '../models/product.dart';
import '../models/shop.dart';
import '../models/favourite.dart';
import '../models/report.dart';
import '../models/request.dart';
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

// GET A SHOP
Future<Shop> getShop(String shopId) async {
  final shopRef = FirebaseFirestore.instance.collection('shops').doc(shopId);
  final sh = await shopRef.get();
  return Shop.fromUniqueFirestore(sh.data(), shopId);
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

//UPDATE A PRODUCTS NAME
Future<void> updateProductName(String shop, String product, String name) async {
  final userRef = FirebaseFirestore.instance
      .collection("shops")
      .doc(shop)
      .collection('products')
      .doc(product);
  if ((await userRef.get()).exists) {
    await userRef.update({'name': name});
  } else {}
}

//UPDATE A PRODUCTS DESCRIPTION
Future<void> updateProductDescription(
    String shop, String product, String description) async {
  final userRef = FirebaseFirestore.instance
      .collection("shops")
      .doc(shop)
      .collection('products')
      .doc(product);
  if ((await userRef.get()).exists) {
    await userRef.update({'description': description});
  } else {}
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

// UDPDATE CHAT LAST MESSAGE
Future<void> updateChatLastMessage(String chat, String lastMessage) async {
  final userRef = FirebaseFirestore.instance.collection("chats").doc(chat);
  if ((await userRef.get()).exists) {
    await userRef.update({'lastMessage': lastMessage});
  } else {}
}

/*Future<void> updateChatDatetime(String chat, String lastMessage) async {
  final userRef = FirebaseFirestore.instance.collection("chats").doc(chat);
  if ((await userRef.get()).exists) {
    await userRef.update({'lastMessage': lastMessage});
  } else {}
}*/

//  CHECK IF A SHOP IS A FAVOURITE
Future<List<Chat>> queryChat(
    String userId, String craftsmanId, String productId) async {
  final validationQuery = await FirebaseFirestore.instance
      .collection('chats')
      .where('craftsmanId', isEqualTo: craftsmanId)
      .where('userId', isEqualTo: userId)
      .where('productId', isEqualTo: productId)
      .snapshots()
      .map(toChatList);

  /*print(.toString());
  final ans = true;
  print(ans);*/
  return validationQuery.first;
}

Future<List<Chat>> isThereAChat(
    String userId, String craftsmanId, String productId) async {
  final validationQuery = await queryChat(userId, craftsmanId, productId);
  if (craftsmanId == userId) return null;

  /*print(.toString());
  final ans = true;
  print(ans);*/
  return validationQuery;
}
//MESSAGES--------------------------------------------------

//GET THE MESSAGES OF A CHAT
Stream<List<Message>> getMessages(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats/$chatId/messages')
      .orderBy('datetime', descending: true)
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

//  CHECK IF A SHOP IS A FAVOURITE
Future<List<Favourite>> queryFavourite(String userId, String shopId) async {
  final validationQuery = await FirebaseFirestore.instance
      .collection('users/$userId/favourites')
      .where('shopId', isEqualTo: shopId)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map(toFavouriteList);

  /*print(.toString());
  final ans = true;
  print(ans);*/
  return validationQuery.first;
}

Future<bool> isFavourite(String userId, String shopId) async {
  final validationQuery = await queryFavourite(userId, shopId);

  /*print(.toString());
  final ans = true;
  print(ans);*/
  return validationQuery.length != 0;
}

//DELETE A FAVOURITE
Future<void> deleteFavorurite(String userId, String shopId) async {
  final fav = await queryFavourite(userId, shopId);
  await FirebaseFirestore.instance
      .collection('users/$userId/favourites')
      .doc(fav.first.id)
      .delete();
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

//GET ALL THE REQUEST
Stream<List<Request>> getRequest() {
  return FirebaseFirestore.instance
      .collection('/requests')
      .orderBy('datetime', descending: false)
      .snapshots()
      .map(toRequestList);
}

//GET MY REQUEST
Stream<List<Request>> getMyRequest(String uid) {
  return FirebaseFirestore.instance
      .collection('/requests')
      .where('userId', isEqualTo: uid)
      //.orderBy('datetime', descending: false)
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

//UPDATE CHECKED STATE
Future<void> updateChecked(String request) async {
  final userRef =
      FirebaseFirestore.instance.collection("requests").doc(request);
  if ((await userRef.get()).exists) {
    await userRef.update({'checked': true});
  } else {}
}

//UPDATE APPROVED STATE
Future<void> updateApproved(String request) async {
  final userRef =
      FirebaseFirestore.instance.collection("requests").doc(request);
  if ((await userRef.get()).exists) {
    await userRef.update({'approved': true});
  } else {}
}
