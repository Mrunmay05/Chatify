import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_pr/components/welcom_button.dart';
import 'package:flashchat_pr/constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id='registration_screen';
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner=false;
  final _auth=FirebaseAuth.instance;
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
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter you email id',
                  hintStyle:const TextStyle(
                    color: Colors.grey
                  )
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
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  )
                )
              ),
              const SizedBox(
                height: 24.0,
              ),
              welcome_button(color: Colors.blueAccent, text: const Text('Register'), func: () async{
                setState(() {
                  showSpinner=true;
                });
                try{
                  UserCredential newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newUser!=null){
                    print('used');
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  log(e.toString());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}