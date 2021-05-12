import 'package:flutter/material.dart';
import 'package:nukak/controller/authentication_service.dart';
import 'package:nukak/view/chat/screens/chats/chats_screen.dart';
import 'package:nukak/view/profile/Login/change_password.dart';
import 'package:nukak/view/profile/Login/my_shops.dart';
import 'package:nukak/view/profile/Login/register_as_seller.dart';
import 'package:nukak/view/profile/Login/createShop.dart';
import 'package:nukak/view/profile/Login/review_requests.dart';
import 'package:nukak/view/profile/profile.dart';
import 'package:provider/provider.dart';
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
            press: () {
              context.read<AuthenticationService>().signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BodyUser extends StatelessWidget {
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
            text: "Revisar solicitud",
            icon: "assets/images/trade.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyRequest(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Cerrar sesión",
            icon: "assets/images/logout.png",
            press: () {
              print('hola?');
              context.read<AuthenticationService>().signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BodyCraftsman extends StatelessWidget {
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
            text: "Chats con usuarios",
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
            text: "Chats con otros artesanos",
            icon: "assets/images/chat.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatsScreenCraftsman(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Crear tienda",
            icon: "assets/images/add.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateShop(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Mis Tiendas",
            icon: "assets/images/add.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeViewCraftsman(),
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
            text: "Cerrar sesión",
            icon: "assets/images/logout.png",
            press: () {
              context.read<AuthenticationService>().signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BodyAdmin extends StatelessWidget {
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
            text: "Revisar solicitudes",
            icon: "assets/images/trade.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AllRequests(),
                ),
              );
            },
          ),
          /*ProfileMenu(
            text: "Revisar reportes",
            icon: "assets/images/trade.png",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterSeller(),
                ),
              );
            },
          ),*/
          ProfileMenu(
            text: "Cerrar sesión",
            icon: "assets/images/logout.png",
            press: () {
              context.read<AuthenticationService>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
