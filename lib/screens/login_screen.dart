import 'dart:developer';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flashchat_pr/components/welcom_button.dart';
import 'package:flashchat_pr/constants.dart';
import 'package:flashchat_pr/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
final _auth=FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner=false;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                      color: Colors.black
                  ),
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email id'
                )
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                      color: Colors.black
                  ),
                onChanged: (value) {
                    password=value;
                  //Do something with the user input.
                },
                decoration:kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  hintStyle:const TextStyle(
                    color: Colors.grey
                  )
                )
              ),
              const SizedBox(
                height: 24.0,
              ),
              welcome_button(color: Colors.lightBlueAccent, text: const Text('Log In'), func: () async {
                setState(() {
                  showSpinner=true;
                });
                try{
                  final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  log(e.toString());
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}