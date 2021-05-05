import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // ignore: missing_return
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed IN";
    } catch (e) {
      print("INVALID");
      return "Invalid";
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

  // ignore: missing_return
  Future<UserCredential> signUp({String email, String password}) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }
}

class UserParsing {
  final String userId;
  final String email;
  final String role;
  final String name;
  final String url;
  final String date_of_birth;
  final String tel;
  final String city;

  UserParsing(
      {this.userId,
      this.email,
      this.role,
      this.name,
      this.url,
      this.date_of_birth,
      this.tel,
      this.city});

  // ignore: missing_return
  factory UserParsing.fromJson(Map<String, dynamic> json) {
    try {
      UserParsing up = UserParsing(
        userId: json['userId'],
        email: json['email'],
        role: json['role'],
        name: json['name'],
        url: json['url'],
        date_of_birth: json['date_of_birth'],
        tel: json['tel'],
        city: json['city'],
      );

      return up;
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

class UserHelper {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<UserParsing> getUser(User user) async {
    final userRef = db.collection("users").doc(user.uid);
    final us = await userRef.get();
    return UserParsing.fromJson(us.data());
  }

  static Future<UserParsing> getUserChat(String user) async {
    final userRef = db.collection("users").doc(user);
    final us = await userRef.get();
    return UserParsing.fromJson(us.data());
  }

  static Future<String> saveUser(User user) async {
    Map<String, dynamic> userData = {
      "userId": user.uid,
      "name": user.displayName,
      "email": user.email,
      "created_at": user.metadata.creationTime,
      "role": "user",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/nukak-maku.appspot.com/o/uploads%2Fdownload%20(1).png?alt=media&token=fe93e733-8a5a-4374-9587-3a0065129eea",
      "date_of_birth": "none",
      "tel": "none",
      "city": "none",
    };
    final userRef = db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
    } else {
      await userRef.set(userData);
    }
    return user.uid;
  }

  static updateUserName(String user, String username) async {
    final userRef = db.collection("users").doc(user);
    if ((await userRef.get()).exists) {
      await userRef.update({'name': username});
    } else {}
  }

  static updateProfilePic(String user, String pp) async {
    final userRef = db.collection("users").doc(user);
    if ((await userRef.get()).exists) {
      await userRef.update({'url': pp});
    } else {}
  }

  static updateCity(String user, String city) async {
    final userRef = db.collection("users").doc(user);
    if ((await userRef.get()).exists) {
      await userRef.update({'city': city});
    } else {}
  }

  static updatePhone(String user, String phone) async {
    final userRef = db.collection("users").doc(user);
    if ((await userRef.get()).exists) {
      await userRef.update({'tel': phone});
    } else {}
  }

  static Future<bool> validatePassword(
      User firebaseUser, String password) async {
    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> updatePassword(User firebaseUser, String password) async {
    firebaseUser.updatePassword(password);
  }
}
