import 'dart:io';

import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubit/profile_image_cubit.dart';
import 'package:chatter_box_app/widgets/chat_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({super.key});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  int selectedIndex = -1;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        return SizedBox(
          height: 380,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: List.generate(
              kAvatars.length,
              (index) {
                final profileCubit =
                    BlocProvider.of<ProfileImageCubit>(context);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      profileCubit.selectAvatar(kAvatars[index]);
                    });
                  },
                  child: Center(
                    child: ChatAvatar(
                      image: kAvatars[index],
                      isSelected:
                          profileCubit.selectedAvatar == kAvatars[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
