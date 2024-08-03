import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/auth/wrapper.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [

          //image

          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 160.0, bottom: 40.0),
            child: Image.asset('assets/intro/thankyou.png'),
          ),

          //title

           Padding(
            padding:  EdgeInsets.all(24.0),
            child: Text('Thank You!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold
            ),
            ),
          ),

          //subtitle

          const Text('Your Order Will Deliver ASAP!',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
          ),),


          // get start Button
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper()));
            },
            child: Container(
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 25.0,right: 25.0),
              decoration: BoxDecoration(
                color: Colors.black,
                 borderRadius: BorderRadius.circular(10)
              ),
              child: Text('Go To Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),),
            ),
          ),

          Spacer(),




        ],
      ),
    );
  }
}