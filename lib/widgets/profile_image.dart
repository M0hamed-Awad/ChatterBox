import 'dart:io';

import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubit/profile_image_cubit.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        final profileImagePath =
            BlocProvider.of<ProfileImageCubit>(context).getProfileImage();
        return checkProfileImageStates(state, profileImagePath);
      },
    );
  }

  CircleAvatar checkProfileImageStates(
      ProfileImageState state, String profileImagePath) {
    if (state is ProfileImageFailure) {
      return const CircleAvatar(
        radius: 80,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 75,
          backgroundColor: kSubTextColor,
          child: Icon(
            Icons.error,
            size: 64,
            color: Colors.red,
          ),
        ),
      );
    } else if (state is ProfileImageLoading) {
      return const CircleAvatar(
        radius: 80,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: CustomLoadingIndicator(),
        ),
      );
    } else {
      return CircleAvatar(
        radius: 80,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 75,
          backgroundColor: Colors.transparent,
          backgroundImage: profileImagePath.startsWith('assets/')
              ? AssetImage(profileImagePath)
              : FileImage(File(profileImagePath)) as ImageProvider,
        ),
      );
    }
  }
}
