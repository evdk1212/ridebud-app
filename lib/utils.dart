import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      content: Text(text,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white),),),
  );
}