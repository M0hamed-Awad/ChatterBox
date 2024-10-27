import 'package:chatter_box_app/constants.dart';

class ChatModel {
  final String id;
  List<String> participants;

  ChatModel({
    required this.id,
    required this.participants,
  });

  factory ChatModel.fromJson(jsonData) {
    return ChatModel(
      id: jsonData[kChatId],
      participants: List<String>.from(jsonData[kChatParticipants] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kChatId: id,
      kChatParticipants: participants,
    };
  }
}
