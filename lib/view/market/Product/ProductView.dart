import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nukak/models/product.dart';
import 'package:nukak/view/home/HomeView.dart';
import 'package:nukak/view/market/MarketView.dart';
import '../../../constants.dart';
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

  Widget editProductView() {}

  Future<void> showEditDialog(BuildContext context, bool isAndroid) async {
    if (isAndroid) {
      return await showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox(
                title: "Editar producto",
                descriptions:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at ante ante. Quisque egestas a ligula nec dapibus. Donec sit amet lacus eget nisi ultricies ullamcorper. Fusce pulvinar rhoncus neque et mollis. Nunc aliquam cursus dolor, sit amet lobortis nunc dignissim eu. Aliquam cursus a ante sed condimentum. ",
                text: "ok");
          });
    } else {}
  }

  Future<void> showDeleteDialog(BuildContext context, bool isAndroid) async {
    if (isAndroid) {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Eliminar producto",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              content: Text(
                  "Desea eliminar este producto? esta accion es irreversible...",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              actions: [
                TextButton(
                    onPressed: () {
                      print("did press yes");
                      Navigator.of(context).pop();
                    },
                    child: Text("Si")),
                TextButton(
                    onPressed: () {
                      print("did pres no");
                      Navigator.of(context).pop();
                    },
                    child: Text("No"))
              ],
              backgroundColor: Color.fromRGBO(168, 84, 27, 1),
            );
          });
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Eliminar producto"),
              content: Text(
                  "Desea eliminar este producto? esta accion es irreversible..."),
              actions: [
                TextButton(
                    onPressed: () {
                      print("did press yes");
                      Navigator.of(context).pop();
                    },
                    child: Text("Si")),
                TextButton(
                    onPressed: () {
                      print("did pres no");
                      Navigator.of(context).pop();
                    },
                    child: Text("No"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 215, 171, 1),
      appBar: getAppBarHome(context),
      body: Body(product: widget.product),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      //Init Floating Action Bubble
      floatingActionButton: isAdmin
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
                      showEditDialog(context, true);
                    } else {
                      showEditDialog(context, false);
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
                      await showDeleteDialog(context, true);
                    } else {
                      await showDeleteDialog(context, false);
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
