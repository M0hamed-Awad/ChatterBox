import 'package:chatter_box_app/widgets/avatar_selector.dart';
import 'package:chatter_box_app/widgets/profile_image.dart';
import 'package:chatter_box_app/widgets/uploade_image_row.dart';
import 'package:flutter/material.dart';

class ProfileImageSelectionSection extends StatelessWidget {
  const ProfileImageSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AvatarSelector(),
        SizedBox(
          height: 30,
        ),
        UploadImageRow(),
        SizedBox(
          height: 16,
        ),
        ProfileImage(),
      ],
    );
  }
}
