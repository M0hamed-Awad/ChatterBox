import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/views/register_view.dart';
import 'package:chatter_box_app/widgets/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo

              Image.asset(
                kLogo,
                width: 350,
              ),

              const SizedBox(
                height: 15,
              ),

              // Welcome Message

              const Text(
                "Welcome back you've been missed!",
                style: TextStyle(
                  color: kOrangeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // Login Form

              const LoginForm(),

              const SizedBox(
                height: 30,
              ),

              // Register Link

              _registerViewLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerViewLink(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'New Here? ',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, RegisterView.id);
              },
            text: 'Register Now!',
            style: const TextStyle(
              fontSize: 24,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: kTertiaryColor,
            ),
          )
        ],
      ),
    );
  }
}
