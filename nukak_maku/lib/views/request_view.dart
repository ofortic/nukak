import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/shop.dart';

import 'package:nukak_maku/models/request.dart';
import 'package:provider/provider.dart';

class CreateRequestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Shop shop = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text(shop.name)),
        body: NewRequestForm(onSend: ( descriptionText) {
          db.sendRequest(shop.id,
              Request( firebaseUser.uid,  descriptionText));
        }));
  }
}

// Define a custom Form widget.
class NewRequestForm extends StatefulWidget {
  final Function onSend;
  NewRequestForm({this.onSend});
  @override
  NewRequestFormState createState() => NewRequestFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class NewRequestFormState extends State<NewRequestForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
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
              controller: descriptionController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          final String descriptionText = descriptionController.text;

          widget.onSend( descriptionText);
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
