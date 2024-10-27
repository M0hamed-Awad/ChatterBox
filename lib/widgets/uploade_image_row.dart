import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubit/profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadImageRow extends StatelessWidget {
  const UploadImageRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Divider(
          height: 24,
          thickness: 2,
          color: kSubTextColor,
          endIndent: 50,
          indent: 50,
        ),
        const Text(
          "OR: ",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        createUploadImageButton(context),
      ],
    );
  }

  GestureDetector createUploadImageButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProfileImageCubit>(context).uploadProfileImage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: kTertiaryColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Upload Image",
              style: TextStyle(
                color: kDarkBackgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Icon(
              Icons.add_a_photo,
              color: kDarkBackgroundColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
