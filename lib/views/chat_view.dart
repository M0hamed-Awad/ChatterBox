import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.chatUser,
  });

  final UserProfileModel chatUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kTextFieldsColor,
          title: _buildAppBarTitle(),
        ),
        body: ChatViewBody(chatUser: chatUser),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(chatUser.profileImageURL),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          chatUser.name,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
