import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/models/chat.dart';
import 'package:nukak/models/message.dart';
import 'package:nukak/view/chat/screens/messages/message_screen.dart';
import 'package:nukak/view/market/Product/components/default_buttom.dart';
import 'package:nukak/models/product.dart';
import '../../../../constants.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:nukak/controller/db.dart' as db;
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final Product product;

  Body({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    Chat ch;
    return FutureBuilder(
        future: UserHelper.getUserChat(product.userId),
        builder: (context, snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Background.png"),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ProductImages(urls: product.url),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      ProductDescription(
                        product: product,
                        pressOnSeeMore: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            child: Column(
                              children: [
                                TopRoundedContainer(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.07,
                                      right: MediaQuery.of(context).size.width *
                                          0.07,
                                      bottom: 0,
                                      top: 0,
                                    ),
                                    child: DefaultButton(
                                      text: "Chat",
                                      press: () {
                                        db
                                            .isThereAChat(firebaseUser.uid,
                                                product.userId, product.id)
                                            .then((value) {
                                          print(value);
                                          if (value != null) {
                                            if (value.length != 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessagesScreen(
                                                    chat: value.first,
                                                    name: snapshot.data.name,
                                                    url: product.url,
                                                    productName: product.name,
                                                    uid: firebaseUser.uid,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ch = Chat(
                                                  product.userId,
                                                  firebaseUser.uid,
                                                  '',
                                                  product.name,
                                                  product.id);
                                              db.sendChat(ch).then((value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessagesScreen(
                                                      chat: ch,
                                                      name: snapshot.data.name,
                                                      url: product.url,
                                                      productName: product.name,
                                                      uid: firebaseUser.uid,
                                                    ),
                                                  ),
                                                );
                                              });
                                            }
                                          } else {
                                            print('invalid');
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget getAppBarHome(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logonukak.png',
            height: MediaQuery.of(context).size.height * 0.09,
            color: Colors.white60,
          ),
        ],
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
    );
  }
}
