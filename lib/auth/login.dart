import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/auth/forgot.dart';
import 'package:shopnest/auth/register.dart';
import 'package:shopnest/globalwidget/dividerText.dart';
import 'package:shopnest/shop/pages/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn() async{
    try{
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text, 
      password: password.text
      );

      Navigator.pushReplacement(
        context,
      MaterialPageRoute(builder: (context) => MainBottom()),
      );
      print('Successfully logged in: ${user.user!.uid} ');

    }catch (e){
      
      print('error loging $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to Login. Check Email & Password",
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
                child: Text('Hi There!',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight:FontWeight.bold,
                ),
                ),
              ),
            ),

            Text('ViewShop',
                style: GoogleFonts.poppins(
                  fontSize: 60,
                  fontWeight:FontWeight.bold,
                ),
                ),
        
            //Form

            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
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

              SizedBox(height: 20.0),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    labelText: 'Password',
                    hintStyle: GoogleFonts.poppins(),
                    labelStyle: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              // forget Password
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                }, 
                child: Text('Forgot Password?',
                style: GoogleFonts.poppins(
                  fontWeight:FontWeight.bold,
                  fontSize:18,
                  color:Colors.black
                ),)),

              SizedBox(height: 20.0),

              //login Button

              GestureDetector(
                onTap: (()=>signIn()),
                child: Container(
                  width: 300,
                  height: 55,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: Center(
                    child: Text('Login',
                    style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    ),),
                  ),
                  ),
              ),
              SizedBox(height: 10,),
              DividerWithText(text: 'Or Continue With'),

              SizedBox(height: 10,),
            //Other Login Options
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  
                  //google

                  GestureDetector(
                onTap: (){},
                child: Container(
                  width: 50,
                  height: 55,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text('G',
                    style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    ),),
                  ),
                  ),
              ),

              SizedBox(width: 30,),
              //facebook

              GestureDetector(
                onTap: (){},
                child: Container(
                  width: 50,
                  height: 55,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text('F',
                    style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    ),),
                  ),
                  ),
              ),
                ],
              ),

              SizedBox(height: 10,),


              //register 


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a Member?',
                  style: GoogleFonts.poppins(
                    fontSize:16,
                    fontWeight:FontWeight.w600,
                    color:Colors.black
                  ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                    }, 
                    child: Text('Register Now',
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
    email.dispose();
    password.dispose();
    super.dispose();
  }
}