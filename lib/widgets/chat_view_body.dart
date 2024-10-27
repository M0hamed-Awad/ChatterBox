import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/models/message_model.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/services/database_service.dart';
import 'package:chatter_box_app/widgets/chat_bubble.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:chatter_box_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatelessWidget {
  ChatViewBody({
    super.key,
    required this.chatUser,
  });

  final UserProfileModel chatUser;

  final TextEditingController _messageTextController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: StreamBuilder(
        stream: _databaseService.getChatMessages(
          receiverUID: chatUser.uid,
        ),
        builder: (context, snapshot) {
          // Chat Messages
          if (snapshot.hasData) {
            List<MessageModel> messages = snapshot.data?.docs.map((doc) {
                  return doc.data();
                }).toList() ??
                [];
            // Scroll to the end once messages are loaded
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollDown();
              }
            });
            return Column(
              children: [
                // Messages
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: messages[index],
                        chatUser: chatUser,
                      );
                    },
                  ),
                ),

                // Text Field Message Input
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context)
                          .viewInsets
                          .bottom // Adjusts for keyboard height
                      ),
                  child: _buildChatTextField(context),
                ),
              ],
            );
          }
          // Errors
          else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Unable to load data.",
                style: TextStyle(
                  color: kErrorColor,
                ),
              ),
            );
          }
          // Loading
          else {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildChatTextField(context) {
    return Container(
      margin: EdgeInsets.only(
        right: 8,
        left: 8,
        bottom: 16,
        top: 8,
      ),
      child: Row(
        children: [
          // Text Field
          Expanded(
            child: CustomTextField(
              hintText: "Send a Message",
              onSubmitted: (message) async {
                await _onFieldSubmitted(messageContent: message, context);
              },
              controller: _messageTextController,
            ),
          ),

          // Send Icon Button
          Container(
            decoration: BoxDecoration(
              color: kSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                if (_messageTextController.text.isNotEmpty) {
                  await _onFieldSubmitted(
                    messageContent: _messageTextController.text,
                    context,
                  );
                }
              },
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onFieldSubmitted(
    context, {
    required String messageContent,
  }) async {
    if (_messageTextController.text.isNotEmpty) {
      await _databaseService.sendMessage(
        receiverUID: chatUser.uid,
        messageContent: messageContent,
      );

      _scrollDown();
      _messageTextController.text = "";
    }
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
