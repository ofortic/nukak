import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  UserParsing({this.userId, this.email, this.role});

  factory UserParsing.fromJson(Map<String, dynamic> json) {
    return UserParsing(
      userId: json['userId'],
      email: json['email'],
      role: json['role'],
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
    };
    final userRef = db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
    } else {
      await userRef.set(userData);
    }
  }
}
