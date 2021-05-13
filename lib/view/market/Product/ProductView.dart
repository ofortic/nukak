import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nukak/models/product.dart';
import 'package:nukak/models/shop.dart';
import 'package:nukak/view/home/HomeView.dart';
import 'package:nukak/view/market/MarketView.dart';
import 'package:nukak/view/market/Product/components/custom_dialog_delete.dart';
import 'components/body.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:nukak/view/market/Product/components/custom_dialog_box.dart';

class ProductView extends StatefulWidget {
  static String routeName = "/details";
  final Product product;
  ProductView({Key key, @required this.product}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  bool isAdmin = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  Future<void> showEditDialog(
      BuildContext context, bool isAndroid, Product pr) async {
    if (isAndroid) {
      return await showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBoxUpdate(
              title: "Editar producto",
              descriptions: "Lorem ipsum",
              text: "ok",
              ancestorContext: context,
              product: pr,
            );
          });
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox(
                title: "Editar producto",
                descriptions: "Lorem ipsum",
                text: "ok");
          });
    }
  }

  Future<void> showDeleteDialog(
      BuildContext context, bool isAndroid, Product pr) async {
    if (isAndroid) {
      return await showDialog(
          context: context,
          builder: (context) {
            return CustomDialogDelete(
              title: "Eliminar producto",
              descriptions:
                  "Esta seguro que desea eliminar este producto? \nEsta accion es irreversible...",
              text: "ok",
              ancestorContext: context,
              product: pr,
            );
          });
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return CustomDialogDelete(
                title: "Eliminar producto",
                descriptions:
                    "Esta seguro que desea eliminar este producto? \nEsta accion es irreversible...",
                text: "ok");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 215, 171, 1),
      appBar: getAppBarHome(context),
      body: Body(product: widget.product),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      //Init Floating Action Bubble
      floatingActionButton: widget.product.userId == firebaseUser.uid
          ? FloatingActionBubble(
              // Menu items
              items: <Bubble>[
                // Floating action menu item
                Bubble(
                  title: "Editar",
                  iconColor: Colors.white,
                  bubbleColor: Color.fromRGBO(168, 84, 27, 1),
                  icon: Icons.edit,
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    _animationController.reverse();
                    if (Platform.isAndroid) {
                      print("Cuadro estamos en Android");
                      showEditDialog(context, true, widget.product);
                    } else {
                      showEditDialog(context, false, widget.product);
                    }
                  },
                ),
                // Floating action menu item
                Bubble(
                  title: "Eliminar",
                  iconColor: Colors.white,
                  bubbleColor: Color.fromRGBO(168, 84, 27, 1),
                  icon: Icons.delete,
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () async {
                    _animationController.reverse();
                    if (Platform.isAndroid) {
                      await showDeleteDialog(context, true, widget.product);
                    } else {
                      await showDeleteDialog(context, false, widget.product);
                    }
                  },
                ),
              ],

              // animation controller
              animation: _animation,

              // On pressed change animation state
              onPress: () => _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward(),

              // Floating Action button Icon color
              iconColor: Color.fromRGBO(168, 84, 27, 1),
              icon: AnimatedIcons.menu_arrow,
            )
          : null,
    );
  }
}
