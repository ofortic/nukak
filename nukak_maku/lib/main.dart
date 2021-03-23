import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/authentication_service.dart';
import 'package:nukak_maku/storage_service.dart';
import 'package:nukak_maku/views/chats_view.dart';
import 'package:nukak_maku/views/create_product.dart';
import 'package:nukak_maku/views/create_shop.dart';
import 'package:nukak_maku/views/messages_view.dart';
import 'package:nukak_maku/views/product_view.dart';
import 'package:nukak_maku/views/products_view.dart';
import 'package:nukak_maku/views/request_view.dart';
import 'package:nukak_maku/views/requests_view.dart';
import 'package:nukak_maku/views/reports_view.dart';
import 'package:nukak_maku/views/favourites_view.dart';
import 'package:nukak_maku/views/shop_view.dart';
import 'package:nukak_maku/views/sign_in.dart';
import 'package:nukak_maku/views/sign_up.dart';
import 'package:nukak_maku/widgets/snerror.dart';
import 'package:provider/provider.dart';

import 'widgets/loading_circle.dart';

void main() => runApp(NukakMakuApp());

class NukakMakuApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SnapshotError(snapshot.error);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          Provider<StorageService>(
            create: (_) => StorageService(FirebaseStorage.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          ),
        ],
        child: MaterialApp(
          title: 'Nukak Maku',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthenticationWrapper(),
          routes: {
            '/products': (_) => ProductsView(),
            '/product': (_) => ProductView(),
            '/create_product': (_) => CreateProductView(),
            '/create_shop': (_) => CreateShopView(),
            '/chats': (_) => ChatsView(),
            '/favourites': (_) => FavouritesView(),
            '/reports': (_) => ReportsView(),
            '/requests': (_) => RequestsView(),
            '/messages': (_) => MessagesView(),
            '/request': (_) => CreateRequestView(),
            '/sign_up': (_) => SignUpView(),
          },
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      UserHelper.saveUser(firebaseUser);
      return ShopsView();
    }
    return SignInView();
  }
}
