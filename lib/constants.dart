import 'package:chatter_box_app/helper/utils.dart';
import 'package:flutter/material.dart';

// Primary Swatch

MaterialColor kPrimarySwatch = generateMaterialColor(
  color: kPrimaryColor,
);

// App Colors

const kPrimaryColor = Color(0xffF14C4B);
const kSecondaryColor = Color(0xFF4AB2F1);
const kTertiaryColor = Color(0xFFF2D74C);
const kDarkBackgroundColor = Color(0xff151C26);
const kTextFieldsColor = Color(0xff5D6A74);
const kOrangeColor = Color(0xffF1B749);
const kSubTextColor = Color(0xffC5C6C9);
const kErrorColor = Color(0xffBE5F71);
const kSuccessColor = Color(0xff12C069);

//______________________________________________________________________________//

// App Logo

const kLogo = "assets/images/logo.png";
const kMiniLogo = "assets/images/mini_logo.png";

//______________________________________________________________________________//

// Firestore Settings

// Users Collection
// Users Collection Name
const kUsersCollection = 'users';

// User UID Document Field
const kUserUID = "uid";

// User Name Document Field
const kUserName = "name";

// User Name Document Field
const kUserEmail = "email";

// User Profile Image Document Field
const kUserProfileImage = "profileImageURL";

//_______________________________________//

// Messages Collection Fields From Firebase

// Collection Name
const kMessagesCollection = 'messages';

// Sender ID Document document
const kMessageSenderId = 'senderId';

// Message Content Document
const kMessageContent = 'message';

// Message Sent At Date Document
const kMessageSentAt = 'sentAt';

//_______________________________________//

// Chats Collection

// Chats Collection Name
const kChatsCollection = 'chats';

// Chat ID Document Field
const kChatId = 'id';

// Participants Document Field
const kChatParticipants = 'participants';

// Messages Document Field
const kChatMessages = 'messages';

//______________________________________________________________________________//

// Code Status For Custom Snack Bar
// ignore: constant_identifier_names
enum CodeStatus { Success, Failure }

// Built-in Avatars For Users To Select From

final List<String> kAvatars = [
  "assets/images/avatars/Avatar1.png",
  "assets/images/avatars/Avatar2.png",
  "assets/images/avatars/Avatar3.png",
  "assets/images/avatars/Avatar4.png",
  "assets/images/avatars/Avatar5.png",
  "assets/images/avatars/Avatar6.png",
  "assets/images/avatars/Avatar7.png",
  "assets/images/avatars/Avatar8.png",
  "assets/images/avatars/Avatar9.png",
];
