import 'package:chatter_box_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Message type for media uplaoding messages functionality
// ignore: constant_identifier_names
enum MessageType { Text, Image }

class MessageModel {
  final String senderId;
  String message;
  final Timestamp sentAt;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.sentAt,
  });

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      senderId: jsonData[kMessageSenderId],
      message: jsonData[kMessageContent],
      sentAt: jsonData[kMessageSentAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kMessageSenderId: senderId,
      kMessageContent: message,
      kMessageSentAt: sentAt,
    };
  }
}
