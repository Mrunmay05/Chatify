import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat_pr/screens/login_screen.dart';
import 'package:flashchat_pr/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_pr/components/welcom_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
      duration:const Duration(
        seconds: 2
      ),
      vsync: this,
    );
    controller?.forward();
    animation=ColorTween(begin: Colors.grey,end: Colors.white).animate(controller!);
    controller?.addListener(() {
      setState(() {

      });
      log((animation?.value).toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('FlashChat',
                    textStyle:const TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            welcome_button(color: Colors.lightBlueAccent,text: const Text('Log in'),func: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },),
            welcome_button(color: Colors.blueAccent, text:const Text('Register'), func: (){
              Navigator.pushNamed(context, RegistrationScreen.id);

            },)
          ],
        ),
      ),
    );
  }
}

