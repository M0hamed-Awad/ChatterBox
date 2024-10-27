import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubit/profile_image_cubit.dart';
import 'package:chatter_box_app/helper/custom_snack_bar.dart';
import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/services/database_service.dart';
import 'package:chatter_box_app/services/storage_service.dart';
import 'package:chatter_box_app/views/login_view.dart';
import 'package:chatter_box_app/widgets/custom_button.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:chatter_box_app/widgets/custom_text_form_field.dart';
import 'package:chatter_box_app/widgets/profile_image_selection_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => Submitting();
}

class Submitting extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          const ProfileImageSelectionSection(),
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            controller: _usernameController,
            hintText: "Username",
            validator: validateUsername,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            controller: _emailController,
            hintText: "Email",
            validator: validateEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            controller: _passwordController,
            hintText: "Password",
            obscureText: true,
            validator: validatePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            controller: _password2Controller,
            hintText: "Confirm Password",
            obscureText: true,
            validator: (password2) {
              if (_passwordController.text != password2) {
                return "Password Don't Match.";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
            onTap: () async {
              await _submitForm();
            },
            title: _createRegisterButtonTitle(),
          ),
        ],
      ),
    );
  }

  // Register Button Title

  Widget _createRegisterButtonTitle() {
    return _isLoading
        ? const CustomLoadingIndicator()
        : const Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          );
  }

  // Registration

  Future<void> _register(
    BuildContext context,
  ) async {
    try {
      await AuthService().registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final StorageService storageService = StorageService();
      final AuthService authService = AuthService();
      final DatabaseService databaseService = DatabaseService();

      final profileImagePath =
          BlocProvider.of<ProfileImageCubit>(context).getProfileImage();

      String profileImageURL;

      profileImageURL = profileImagePath.startsWith("assets/")
          // Uploading Profile Image from local Avatars assets.
          ? await storageService.uploadImageFromAssets(
              assetPath: profileImagePath,
              // Getting the current User UID.
              uid: authService.currentUser!.uid,
            )
          // Uploading Profile Image from The Device.
          : await storageService.uploadImageFromDevice(
              imagePath: profileImagePath,
              // Getting the current User UID.
              uid: authService.currentUser!.uid,
            );

      try {
        await databaseService.createUserProfile(
          userProfileModel: UserProfileModel(
            uid: authService.currentUser!.uid,
            name: _usernameController.text,
            email: _emailController.text,
            profileImageURL: profileImageURL,
          ),
        );
      } catch (e) {
        throw Exception("Unable to upload the user profile image.\nError: $e");
      }
    } catch (e) {
      throw Exception("Unable to register the user: ${e.toString()}");
    }
  }

  // Submitting the Form

  Future<void> _submitForm() async {
    if (_registerFormKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _register(context);
        showCustomSnackBar(
          context,
          snackBarMessage: 'Account Created Successfully.',
          status: CodeStatus.Success,
        );
        Navigator.pushReplacementNamed(context, LoginView.id);
      } on FirebaseAuthException catch (e) {
        _registrationExceptionsHandling(
          context: context,
          exception: e,
        );
      } catch (e) {
        showCustomSnackBar(
          context,
          snackBarMessage:
              'Failed To Create The Account Created.\nPlease Try Again.',
          status: CodeStatus.Success,
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Registration Error Handling

  void _registrationExceptionsHandling({
    required BuildContext context,
    required FirebaseAuthException exception,
  }) {
    if (exception.code == 'weak-password') {
      showCustomSnackBar(
        context,
        snackBarMessage: 'The password is too weak.',
        status: CodeStatus.Failure,
      );
    } else if (exception.code == 'email-already-in-use') {
      showCustomSnackBar(
        context,
        snackBarMessage: 'The account already exists.',
        status: CodeStatus.Failure,
      );
    }
  }
}
