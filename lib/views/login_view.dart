import 'package:chatter_box_app/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static String id = 'NewLoginView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LoginViewBody(),
    );
  }
}
