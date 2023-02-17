import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat_pr/screens/chat_screen.dart';
import 'package:flashchat_pr/screens/login_screen.dart';
import 'package:flashchat_pr/screens/registration_screen.dart';
import 'package:flashchat_pr/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}