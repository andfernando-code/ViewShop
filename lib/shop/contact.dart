import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactNow extends StatelessWidget {
  const ContactNow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [

          //image

          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 160.0, bottom: 40.0),
            child: Image.asset('assets/intro/hotline.png'),
          ),

          //title

           Padding(
            padding:  EdgeInsets.all(24.0),
            child: Text('076-1794522 \ 0770430503 ',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold
            ),
            ),
          ),

          

          // get start Button
          Spacer(),
          GestureDetector(
            onTap: () {
             
            },
            child: Container(
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 25.0,right: 25.0),
              decoration: BoxDecoration(
                color: Colors.black,
                 borderRadius: BorderRadius.circular(12)
              ),
              child: Text('Call Now Hotline',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),),
            ),
          ),


          SizedBox(height: 20,),

          GestureDetector(
            onTap: () {
             Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 25.0,right: 25.0),
              decoration: BoxDecoration(
                color: Colors.black,
                 borderRadius: BorderRadius.circular(12)
              ),
              child: Text('Back to Store',
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