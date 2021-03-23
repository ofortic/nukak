import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/product.dart';
import 'package:nukak_maku/models/shop.dart';
import 'package:provider/provider.dart';

import '../storage_service.dart';

class CreateProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Shop shop = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text(shop.name)),
        body: NewProductForm(onSend: (nameText, descriptionText, ref) {
          context
              .read<StorageService>()
              .getDownloadUrl(context, ref)
              .then((value) {
            db.sendProduct(
                shop.id,
                Product(nameText, firebaseUser.uid, shop.id, descriptionText,
                    value));
          });
        }));
  }
}

// Define a custom Form widget.
class NewProductForm extends StatefulWidget {
  final Function onSend;
  NewProductForm({this.onSend});
  @override
  NewProductFormState createState() => NewProductFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class NewProductFormState extends State<NewProductForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  File _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _imageFile = File(pickedFile.path);
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: descriptionController,
            ),
          ),
          ElevatedButton(
            child: Icon(
              Icons.add_a_photo,
              size: 50,
            ),
            onPressed: pickImage,
          ),
        ],
      ),
      // ignore: deprecated_member_use

      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          final String nameText = nameController.text;
          final String descriptionText = descriptionController.text;
          context
              .read<StorageService>()
              .uploadImageToFirebase(context, _imageFile)
              .then((value) {
            widget.onSend(nameText, descriptionText, value);
          });
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
