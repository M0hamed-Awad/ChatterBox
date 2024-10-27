import 'dart:io';
import 'package:chatter_box_app/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageInitial());

  String profileImage = "assets/images/default_profile_image.png";
  String? selectedAvatar;

  uploadProfileImage() async {
    debugPrint("Loading");
    emit(
      ProfileImageLoading(),
    );
    try {
      File? file = await MediaService().getImageFromGallery();

      if (file != null) {
        profileImage = file.path;
        selectedAvatar = null;
      }

      emit(
        ProfileImageSuccess(),
      );
    } catch (e) {
      emit(
        ProfileImageFailure(
          e.toString(),
        ),
      );
      debugPrint("failure");
    }
  }

  // Function to select an avatar
  void selectAvatar(String avatarPath) {
    selectedAvatar = avatarPath; // Save selected avatar path
    profileImage = avatarPath; // Clear uploaded image if an avatar is selected
    emit(
      ProfileImageSuccess(),
    ); // Trigger UI update
  }

  // Method to get the current image (avatar, uploaded, or default)
  String getProfileImage() {
    if (selectedAvatar != null) {
      return selectedAvatar!;
    } else {
      return profileImage;
    }
  }
}
