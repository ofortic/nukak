import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nukak/view/home/loading_circle.dart';
import 'package:nukak/view/home/snerror.dart';
import 'package:nukak/view/profile/Login/LoginView.dart';
import 'package:nukak/view/root_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/authentication_service.dart';
import 'controller/storage_service.dart';

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
    return MultiProvider(providers: [
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
    ], child: AuthenticationWrapper());
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      UserHelper.saveUser(firebaseUser);
      return new MaterialApp(home: RootApp());
    }
    return new MaterialApp(home: LoginView());
  }
}
