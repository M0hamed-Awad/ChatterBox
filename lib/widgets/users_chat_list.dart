import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:chatter_box_app/services/database_service.dart';
import 'package:chatter_box_app/views/chat_view.dart';
import 'package:chatter_box_app/widgets/chat_tile.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersChatList extends StatelessWidget {
  UsersChatList({super.key});

  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<UserProfileModel>>(
      stream: _databaseService.getUsersProfiles(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserProfileModel user = users[index].data();
              return ChatTile(
                user: user,
                onTap: () async {
                  // Check If the Chat Already Exists OR NOT.
                  final isChatExists = await _databaseService.checkIfChatExists(
                    receiverUID: user.uid,
                  );

                  if (!isChatExists) {
                    await _databaseService.createNewChat(
                      uid1: _authService.currentUser!.uid,
                      receiverUID: user.uid,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatView(
                        chatUser: user,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Unable to load data.",
              style: TextStyle(
                color: kErrorColor,
              ),
            ),
          );
        }
        return const Center(
          child: CustomLoadingIndicator(),
        );
      },
    );
  }
}
