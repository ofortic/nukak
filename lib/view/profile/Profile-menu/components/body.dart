import 'package:flutter/material.dart';
import 'package:nukak/view/chat/screens/chats/chats_screen.dart';
import 'package:nukak/view/profile/Login/change_password.dart';
import 'package:nukak/view/profile/Login/register_as_seller.dart';
import 'package:nukak/view/profile/profile.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Image.asset("assets/images/logonukak.png"),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Mi perfil",
            icon: "assets/images/user.png",
            press: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              ),
            },
          ),
          ProfileMenu(
            text: "Chats",
            icon: "assets/images/chat.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatsScreen(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Cambiar contraseña",
            icon: "assets/images/padlock.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangePassword(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Vender productos",
            icon: "assets/images/trade.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterSeller(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Cerrar sesión",
            icon: "assets/images/logout.png",
            press: () {},
          ),
        ],
      ),
    );
  }
}
