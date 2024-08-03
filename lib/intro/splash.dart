import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/intro/introwrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
      with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const IntroWrapper())
      );
    });
  }

  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ViewShop',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}