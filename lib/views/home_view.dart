import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:chatter_box_app/widgets/custom_drawer.dart';
import 'package:chatter_box_app/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  static String id = "HomeView";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> logout() async {
    await AuthService().logout();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Image.asset(
            kMiniLogo,
            width: 60,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.dehaze,
              size: 24,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: const CustomDrawer(),
        body: const HomeViewBody(),
      ),
    );
  }
}
