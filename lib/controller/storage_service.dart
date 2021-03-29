//Caution: Only works on Android & iOS platforms
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//void main() => runApp(MyApp());

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class StorageService {
  final FirebaseStorage _firebaseStorage;
  StorageService(this._firebaseStorage);

  Future<Reference> uploadImageToFirebase(
      BuildContext context, File img) async {
    try {
      String fileName = basename(img.path);
      Reference ref = _firebaseStorage.ref().child("uploads/$fileName");
      await ref.putFile(img);
      return ref;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // ignore: missing_return
  Future<String> downloadImageFromFirebase(
      BuildContext context, String img) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = '${appDocDir.path}/download-img.png';
    File downloadToFile = File(path);
    try {
      await _firebaseStorage.ref(img).writeToFile(downloadToFile);
      return path;
    } on Exception catch (e) {
      print(e.toString());
      // e.g, e.code == 'canceled'
    }
  }

  Future<String> getDownloadUrl(BuildContext context, Reference ref) {
    return ref.getDownloadURL();
  }
}

/*
class StorageHelper {
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
}*/
