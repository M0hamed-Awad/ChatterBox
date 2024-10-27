import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/services/auth/auth_gate.dart';
import 'package:chatter_box_app/themes/dark_mode.dart';
import 'package:chatter_box_app/views/home_view.dart';
import 'package:chatter_box_app/views/login_view.dart';
import 'package:chatter_box_app/views/register_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupFirebase();
  runApp(
    const ChatterBoxApp(),
  );
}

class ChatterBoxApp extends StatelessWidget {
  const ChatterBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkModeTheme,
      themeMode: ThemeMode.dark,
      routes: {
        HomeView.id: (context) => HomeView(),
        AuthGate.id: (context) => const AuthGate(),
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
      },
      initialRoute: AuthGate.id,
    );
  }
}
