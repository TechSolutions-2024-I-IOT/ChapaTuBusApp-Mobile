import 'package:chapa_tu_bus_app/account_management/presentation/screens/auth/login_or_register_screen.dart';
import 'package:chapa_tu_bus_app/common/utils/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const HomeScreen(pageIndex: 0,);
          }

          // user is NOT logged in
          else {
            return const LogInOrRegisterScreen();
          }
        },
      ),
    );
  }
}