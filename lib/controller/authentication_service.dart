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

  factory UserParsing.fromJson(Map<String, dynamic> json) {
    return UserParsing(
      userId: json['userId'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      url: json['url'],
      date_of_birth: json['date_of_birth'],
      tel: json['tel'],
      city: json['city'],
    );
  }
}

class UserHelper {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<UserParsing> getUser(User user) async {
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
      "date_of_birth": "none",
      "tel": "none",
      "city": "none",
    };
    final userRef = db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
    } else {
      await userRef.set(userData);
    }
  }
}
