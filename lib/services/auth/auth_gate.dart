import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:chatter_box_app/views/home_view.dart';
import 'package:chatter_box_app/views/login_view.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  static String id = 'AuthGate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          // User is Logged In
          if (snapshot.hasData) {
            return HomeView();
          }
          // User Logged Out
          else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
