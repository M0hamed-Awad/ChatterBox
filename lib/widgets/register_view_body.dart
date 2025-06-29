import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:chatter_box_app/views/login_view.dart';
import 'package:chatter_box_app/widgets/register_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => ProfileImageCubit(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo

                Image.asset(
                  kLogo,
                  width: 300,
                ),
 
                // Welcome Message

                const Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: kOrangeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                const Text(
                  "Choose An Avatar:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // Registration Form

                const RegisterForm(),

                const SizedBox(
                  height: 30,
                ),

                // Register Link

                _registerViewLink(context),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerViewLink(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Already Have An Account? ',
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
                Navigator.pop(context, LoginView.id);
              },
            text: 'Login!',
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
