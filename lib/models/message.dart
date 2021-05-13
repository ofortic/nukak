import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageType { text, image }
enum MessageStatus { not_view }

class Message {
  String id, userId;
  String text;
  DateTime datetime;
  String messageType;
  String messageStatus;
  String image;
  Message.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc.data()['userId'],
        text = doc.data()['text'],
        messageStatus = doc.data()['messageStatus'],
        messageType = doc.data()['messageType'],
        image = doc.data()['image'],
        datetime = (doc.data()['datetime'] as Timestamp).toDate();
  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'text': text,
        'messageType': messageType,
        'messageStatus': messageStatus,
        'image': image,
        'datetime': datetime
      };
  Message(
      this.text, this.userId, this.messageStatus, this.messageType, this.image)
      : datetime = DateTime.now();

  bool isSender(String cuid) {
    return userId == cuid;
  }
}

List<Message> toMessageList(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.docs;
  return docs.map((doc) => Message.fromFirestore(doc)).toList();
}
