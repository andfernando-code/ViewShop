import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopnest/intro/intropage.dart';
import 'package:shopnest/shop/pages/main_screen.dart';

class IntroWrapper extends StatefulWidget {
  const IntroWrapper({super.key});

  @override
  State<IntroWrapper> createState() => _IntroWrapperState();
}

class _IntroWrapperState extends State<IntroWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot){
          if(snapshot.hasData){
            return MainBottom();
          }else{
            return IntroPage();
          }
        }
        )
    );
  }
}