import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nukak/controller/storage_service.dart';
import 'package:nukak/models/chat.dart';
import 'package:nukak/models/message.dart';
import 'package:provider/provider.dart';
import 'package:nukak/constants.dart';
import 'package:nukak/controller/db.dart' as db;
import 'dart:io';

class ChatInputField extends StatelessWidget {
  ChatInputField({Key key, @required this.chat}) : super(key: key);

  final Chat chat;
  TextEditingController myController = TextEditingController();
  String messageType;
  String messageStatus;
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
  }

  File _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) _imageFile = File(pickedFile.path);
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) _imageFile = File(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    messageType = 'text';
    messageStatus = 'not_view';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: "Escribe tu mensaje",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        messageType = 'image';
                        pickImageFromGallery();
                      },
                      child: Icon(
                        Icons.attach_file,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    GestureDetector(
                      onTap: () {
                        messageType = 'image';
                        pickImageFromCamera();
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    if (myController.text.trim().length > 0 &&
                        messageType == 'text') {
                      db
                          .sendMessage(
                              chat.id,
                              Message(myController.text, firebaseUser.uid,
                                  messageStatus, messageType, 'none'))
                          .then((value) {
                        messageType = 'text';
                        db.updateChatLastMessage(chat.id, myController.text);
                      });
                      print(myController.text);
                    } else if (messageType == 'image' && _imageFile != null) {
                      print('image');
                      StorageService ss = context.read<StorageService>();
                      ss
                          .uploadImageToFirebase(context, _imageFile)
                          .then((value1) {
                        ss.getDownloadUrl(context, value1).then((value) {
                          db
                              .sendMessage(
                                  chat.id,
                                  Message('', firebaseUser.uid, messageStatus,
                                      messageType, value))
                              .then((value) {
                            db.updateChatLastMessage(
                                chat.id, 'Archivo adjunto');
                          });
                        });
                      });
                    }
                  },
                  child: Image.asset(
                    "assets/images/send.png",
                    width: 25,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
