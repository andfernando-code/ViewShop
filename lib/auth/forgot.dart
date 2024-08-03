import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/auth/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController _email = TextEditingController();

  reset() async{
    String email = _email.text;
    try{

      //send reset password email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      //show successfull message

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(" Password Reset Email sent Successfully.",
        style: GoogleFonts.poppins(
          fontSize: 16,
          color:Colors.white,
        ),),
        backgroundColor: Colors.black,
        ));

      //redirect to login page

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));



    }catch (e){
      print('Error Sending Password Reset Link $e');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to Send Password Reset Email.",
        style: GoogleFonts.poppins(
          fontSize: 16
        ),),
        backgroundColor: Colors.red,
        ));
    }
  }
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            //Title
            Padding(
              padding: const EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
              child: Center(
                child: Text('Reset Your Password!',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight:FontWeight.bold,
                ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            
        
            //Form

            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    labelText: 'E-mail',
                    hintStyle: GoogleFonts.poppins(),
                    labelStyle: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              
              //reset Button

              GestureDetector(
                onTap: (()=>reset()),
                child: Container(
                  width: 300,
                  height: 55,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: Center(
                    child: Text('Reset Password',
                    style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    ),),
                  ),
                  ),
              ),
              
              SizedBox(height: 10,),


              //register 


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('I remeber password?',
                  style: GoogleFonts.poppins(
                    fontSize:16,
                    fontWeight:FontWeight.w600,
                    color:Colors.black
                  ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text('Login',
                    style: GoogleFonts.poppins(
                      fontSize:16,
                    fontWeight:FontWeight.w600,
                    color:Colors.blueAccent
                    )
                    ,))
                ],
              ),
             
            ],
          ),
 
        ),
      
    );
  }

  //cleanup form fields
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }
}