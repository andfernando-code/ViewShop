import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/auth/login.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name;
  late String city;
  late String mobile;
  late String email;
  late String password;
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              //title
              Padding(
                padding: const EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
                child: Center(
                  child: Text('Create an Account.',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight:FontWeight.bold,
                  ),
                  ),
                ),
              ),
          
              Text('ShopNest',
                  style: GoogleFonts.poppins(
                    fontSize: 60,
                    fontWeight:FontWeight.bold,
                  ),
                  ),
          
              //register form
              Container(
                height: 500,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      //name
                      TextFormField(
                        
                        decoration:  InputDecoration(
                          labelText: 'Your Name',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold
                          ),
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(), 
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                        },
                        onSaved: (value) {
                        name = value!;
                      },
                        
                      ),
                      SizedBox(height: 10,),
          
                      //city
                      TextFormField(
                        
                        decoration:  InputDecoration(
                          labelText: 'Your City',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold
                          ),
                          hintText: 'Enter your city',
                          border: OutlineInputBorder(), 
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please Enter City';
                            }
                            return null;
                        },
                        onSaved: (value) {
                        city = value!;
                      },
                        
                      ),
                      SizedBox(height: 10,),
          
                      //mobile
                      TextFormField(
                        
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Your Mobile Number',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold
                          ),
                          hintText: 'Enter Your Mobile Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please Enter Mobile';
                            }
                            return null;
                        },
                        onSaved: (value) {
                        mobile = value!;
                      },
                      ),
                      SizedBox(height: 10,),
          
                      //mobile
                      TextFormField(
                        
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Your E-mail',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold
                          ),
                          hintText: 'Enter Your E-mail',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please Enter E-mail';
                            }
                            return null;
                        },
                        onSaved: (value) {
                        email = value!;
                      },
                      ),
                      SizedBox(height: 10,),
          
                      //password
                      TextFormField(
                        
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Your Password',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold
                          ),
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                        },
                        onSaved: (value) {
                        password = value!;
                      },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Register Button

                      GestureDetector(
                        onTap: (){
                          submitForm();
                        },
                        child: Container(
                          width: 300,
                          height: 55,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.black
                          ),
                          child: Center(
                            child: Text('Register',
                            style: GoogleFonts.poppins(
                              fontWeight:FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white
                    ),),
                  ),
                  ),
              ),
                    ],
                  )
                  ),
              ),

              //Already Memebr Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Member?',
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
      ),
    );
  }


void submitForm() async{
  if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try{

        //register user in firebase auth
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password,
          );
        //store user other details on firestore

        await FirebaseFirestore.instance.collection('Users').doc(user.user!.uid).set({
            'name':name,
            'email':email,
            'phone':mobile,
            'city':city,

        });

        //clear register form after register customer

        _formKey.currentState!.reset();

        // redirect user to login after registation
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));

      }catch (e){

        print('Unsuccessfull Register $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             content: Text("Failed to Register. Try Again!",
              style: GoogleFonts.poppins(
               fontSize: 16
              ),),
        backgroundColor: Colors.red,
        ));
        

      }
  }
}
}