import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:chatter_box_app/cubits/register_cubit/register_cubit.dart';
import 'package:chatter_box_app/helper/custom_snack_bar.dart';
import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/views/login_view.dart';
import 'package:chatter_box_app/widgets/custom_button.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:chatter_box_app/widgets/custom_text_form_field.dart';
import 'package:chatter_box_app/widgets/profile_image_selection_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          showCustomSnackBar(
            context,
            snackBarMessage: state.errorMessage,
            status: CodeStatus.Failure,
          );
        } else if (state is RegisterSuccess) {
          showCustomSnackBar(
            context,
            snackBarMessage: "Account Created Successfully.",
            status: CodeStatus.Success,
          );
          Navigator.popAndPushNamed(context, LoginView.id);
        }
      },
      builder: (context, state) {
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
                isEnabled: state is RegisterLoading ? false : true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: _emailController,
                hintText: "Email",
                validator: validateEmail,
                isEnabled: state is RegisterLoading ? false : true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
                validator: validatePassword,
                isEnabled: state is RegisterLoading ? false : true,
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
                isEnabled: state is RegisterLoading ? false : true,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                onTap: () async {
                  await _submitForm(context);
                },
                title: _createRegisterButtonTitle(state),
              ),
            ],
          ),
        );
      },
    );
  }

  // Register Button Title

  Widget _createRegisterButtonTitle(RegisterState state) {
    return state is RegisterLoading
        ? const CustomLoadingIndicator(
            indicatorColor: Colors.white,
          )
        : const Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          );
  }

  // Submitting the Form

  Future<void> _submitForm(BuildContext context) async {
    final profileImagePath =
        BlocProvider.of<ProfileImageCubit>(context).getProfileImage();
    if (_registerFormKey.currentState?.validate() ?? false) {
      BlocProvider.of<RegisterCubit>(context).register(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        userProfileImagePath: profileImagePath,
      );
    }
  }
}
