// import 'package:firebase_demo/screens/happy_screen.dart';
// import 'package:firebase_demo/screens/poll_screen.dart';
import 'package:firebase_demo/screens/upload_file_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset('assets/logo.jpg'));
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to the Cookbook App! Sign in to continue'
                      : 'Welcome to the Cookbook App! Create an account',
                ),
              );
            },
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Powered by ME!!!!!',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        } else {
          return const UploadFileScreen();
        }
      },
    );
  }
}
