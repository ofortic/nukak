import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((e) {
        print(e.toString());
      });
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ignore: missing_return
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    if (googleUser == null) {
      print('NOT LOGGED IN');
    } else {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await _firebaseAuth.signInWithCredential(credential);
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.message;
    }
  }
}

class UserParsing {
  final String userId;
  final String email;
  final String role;
  final String url;

  UserParsing({this.userId, this.email, this.role, this.url});

  factory UserParsing.fromJson(Map<String, dynamic> json) {
    return UserParsing(
      userId: json['userId'],
      email: json['email'],
      role: json['role'],
      url: json['url'],
    );
  }
}

class UserHelper {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<UserParsing> getUserRole(User user) async {
    final userRef = db.collection("users").doc(user.uid);
    final us = await userRef.get();
    return UserParsing.fromJson(us.data());
  }

  static saveUser(User user) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "created_at": user.metadata.creationTime,
      "role": "user",
      "url": "none",
    };
    final userRef = db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
    } else {
      await userRef.set(userData);
    }
  }
}
