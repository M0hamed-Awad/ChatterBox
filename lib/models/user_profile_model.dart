// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatter_box_app/constants.dart';

class UserProfileModel {
  String uid;
  String name;
  String email;
  String profileImageURL;

  UserProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImageURL,
  });

  factory UserProfileModel.fromJson(jsonData) {
    return UserProfileModel(
      uid: jsonData[kUserUID],
      name: jsonData[kUserName],
      email: jsonData[kUserEmail],
      profileImageURL: jsonData[kUserProfileImage],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUserUID: uid,
      kUserName: name,
      kUserEmail: email,
      kUserProfileImage: profileImageURL,
    };
  }
}
