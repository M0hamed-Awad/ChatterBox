import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/models/chat_model.dart';
import 'package:chatter_box_app/models/message_model.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference? _usersCollection;
  CollectionReference? _chatsCollection;

  late AuthService _authService;

  DatabaseService() {
    _authService = AuthService();
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _usersCollection = _firebaseFirestore
        .collection(kUsersCollection)
        .withConverter<UserProfileModel>(
          fromFirestore: (snapshot, _) => UserProfileModel.fromJson(
            snapshot.data(),
          ),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );

    _chatsCollection = _firebaseFirestore
        .collection(kChatsCollection)
        .withConverter<ChatModel>(
          fromFirestore: (snapshot, _) => ChatModel.fromJson(
            snapshot.data(),
          ),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  // Users In Database

  Future<void> createUserProfile(
      {required UserProfileModel userProfileModel}) async {
    try {
      await _usersCollection?.doc(userProfileModel.uid).set(userProfileModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot<UserProfileModel>> getUsersProfiles() {
    // Get all the users except the current logged in user
    final usersProfiles = _usersCollection
        ?.where("uid", isNotEqualTo: _authService.currentUser!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfileModel>>;
    return usersProfiles;
  }

  // Chats In Database

  Future<void> createNewChat({
    required String uid1,
    required String receiverUID,
  }) async {
    try {
      // Generate the unique chat ID
      final String chatId = generateChatId(
          uid1: _authService.currentUser!.uid, uid2: receiverUID);

      // Initial Chat
      final ChatModel chat = ChatModel(
        id: chatId,
        participants: [_authService.currentUser!.uid, receiverUID],
      );

      // Generate a new Chat doc in the chats collection with the ID generated later
      await _chatsCollection?.doc(chatId).set(chat);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> checkIfChatExists({
    required String receiverUID,
  }) async {
    try {
      String chatId = generateChatId(
          uid1: _authService.currentUser!.uid, uid2: receiverUID);
      final result = await _chatsCollection?.doc(chatId).get();

      if (result != null) {
        return result.exists;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Stream<QuerySnapshot<MessageModel>> getChatMessages({
    required String receiverUID,
  }) {
    // Get the chat ID
    final String chatId =
        generateChatId(uid1: _authService.currentUser!.uid, uid2: receiverUID);

    return _firebaseFirestore
        .collection(kChatsCollection)
        .doc(chatId)
        .collection(kMessagesCollection)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        )
        .orderBy(kMessageSentAt)
        .snapshots();
  }

  // Messages

  Future<void> sendMessage({
    required String receiverUID,
    required String messageContent,
  }) async {
    try {
      // Determine Chat ID
      final String chatId = generateChatId(
          uid1: _authService.currentUser!.uid, uid2: receiverUID);

      // Creating the message
      MessageModel message = MessageModel(
        senderId: _authService.currentUser!.uid,
        message: messageContent,
        sentAt: Timestamp.now(),
      );

      // Get The Chat By ID
      final chat = _chatsCollection!.doc(chatId);

      // Add Message To The Chat Messages Collecton
      await chat
          .collection(kMessagesCollection)
          .withConverter<MessageModel>(
            // Use the converter to map MessageModel
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (message, _) => message.toJson(),
          )
          .add(message);
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}
