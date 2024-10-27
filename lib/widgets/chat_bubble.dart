import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/models/message_model.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final UserProfileModel chatUser;

  ChatBubble({
    super.key,
    required this.message,
    required this.chatUser,
  });

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    bool isRespond = (message.senderId != _authService.currentUser?.uid);
    return Align(
      alignment: isRespond ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isRespond ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                _buildChatMessageBubble(isRespond),
                Text(
                  DateFormat('E, h:mm a').format(message.sentAt.toDate()),
                  style: const TextStyle(
                    color: kSubTextColor,
                  ),
                )
              ],
            ),
          ),
          if (isRespond)
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(chatUser.profileImageURL),
            ),
        ],
      ),
    );
  }

  Container _buildChatMessageBubble(bool isRespond) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 22,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isRespond ? kSecondaryColor : kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(40),
          topRight: const Radius.circular(40),
          bottomRight:
              isRespond ? const Radius.circular(0) : const Radius.circular(40),
          bottomLeft:
              isRespond ? const Radius.circular(40) : const Radius.circular(0),
        ),
      ),
      child: Text(
        message.message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
