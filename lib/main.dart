import 'package:chatter_box_app/cubits/login_cubit/login_cubit.dart';
import 'package:chatter_box_app/cubits/register_cubit/register_cubit.dart';
import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/services/auth/auth_gate.dart';
import 'package:chatter_box_app/themes/dark_mode.dart';
import 'package:chatter_box_app/views/home_view.dart';
import 'package:chatter_box_app/views/login_view.dart';
import 'package:chatter_box_app/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit())
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
