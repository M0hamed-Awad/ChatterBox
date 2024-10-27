import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/helper/custom_snack_bar.dart';
import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:chatter_box_app/views/home_view.dart';
import 'package:chatter_box_app/widgets/custom_button.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:chatter_box_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  bool _isLoading = false;

  Future<void> _login(
    BuildContext context,
  ) async {
    await AuthService().loginWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void _loginExceptionsHandling({
    required BuildContext context,
    required FirebaseAuthException exception,
  }) {
    if (exception.code == 'user-not-found') {
      showCustomSnackBar(
        context,
        snackBarMessage: 'No user found for that email.',
        status: CodeStatus.Failure,
      );
    } else if (exception.code == 'wrong-password') {
      showCustomSnackBar(
        context,
        snackBarMessage: 'Wrong password provided for that user.',
        status: CodeStatus.Failure,
      );
    } else {
      showCustomSnackBar(
        context,
        snackBarMessage: exception.toString(),
        status: CodeStatus.Failure,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
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
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return "Password field can't be empty.";
              } else {
                return null;
              }
            },
          ),
          // TODO
          // Forget Password Functionally
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 8),
            child: const Text(
              "Forget Password?",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: kSubTextColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
            onTap: () async {
              await _submitForm();
            },
            title: _textButtonTitle(),
          ),
        ],
      ),
    );
  }

  Widget _textButtonTitle() {
    return _isLoading
        ? const CustomLoadingIndicator()
        : const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          );
  }

  Future<void> _submitForm() async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _login(context);
        if (mounted) {
          Navigator.popAndPushNamed(context, HomeView.id);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          _loginExceptionsHandling(
            context: context,
            exception: e,
          );
        }
      } catch (e) {
        if (mounted) {
          showCustomSnackBar(
            context,
            snackBarMessage: e.toString(),
            status: CodeStatus.Failure,
          );
        }
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
