import 'package:flutter/material.dart';

class welcome_button extends StatelessWidget {
  welcome_button({super.key, required this.color,required this.text,required this.func});
  Color color;
  Text text;
  VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
            onPressed: func,
            minWidth: 200.0,
            height: 42.0,
            child: text
        ),
      ),
    );
  }
}