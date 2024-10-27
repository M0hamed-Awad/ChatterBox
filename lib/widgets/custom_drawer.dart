import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/services/auth/auth_gate.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  //   final User? user = AuthService().currentUser;

  Future<void> logout() async {
    await AuthService().logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                kLogo,
                width: 200,
              ),
            ),
          ),
          _createHomeListTile(context),
          const Spacer(
            flex: 8,
          ),
          _createLogoutListTile(context),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  ListTile _createHomeListTile(context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 24,
        top: 24,
        bottom: 16,
      ),
      leading: const Icon(Icons.home),
      title: const Text(
        "Home",
        style: TextStyle(
          letterSpacing: 8,
          fontSize: 24,
          fontWeight: FontWeight.w200,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  ListTile _createLogoutListTile(context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 24,
      ),
      leading: const Icon(Icons.logout),
      title: const Text(
        "Logout",
        style: TextStyle(
          letterSpacing: 8,
          fontSize: 24,
          fontWeight: FontWeight.w200,
        ),
      ),
      onTap: () {
        logout();
        Navigator.popAndPushNamed(context, AuthGate.id);
      },
    );
  }
}
