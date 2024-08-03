import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name;
  String? _email;
  String? _phone;
  String? _city;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Retrieve user data from Firestore using the user's UID
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();

        // Update state with the retrieved user data
        setState(() {
          _name = userData['name'];
          _email = userData['email'];
          _phone = userData['phone'];
          _city = userData['city'];
        });
      } catch (error) {
        print('Error loading user data: $error');
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
        style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 25,
                      color:Colors.black
                    ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20.0),
                    // Profile photo
                    Center(
                      child: CircleAvatar(
                        radius: 100.0,
                        child: Image.asset('assets/profile/profile.png'),
                      ),
                    ),
                    SizedBox(height: 20.0),
           


            ListTile(
              tileColor: Colors.black,
              leading:Icon(Ionicons.person,color: Colors.white),
              title: Text('${_name}',
              style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 18,
                      color:Colors.white
                    ),),
          
             ),

             ListTile(
              tileColor: Colors.black,
              leading:Icon(Ionicons.mail,color: Colors.white),
              title: Text('${_email}',
              style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 18,
                      color:Colors.white
                    ),),
          
             ),

             ListTile(
              tileColor: Colors.black,
              leading:Icon(Ionicons.call,color: Colors.white),
              title: Text('${_phone}',
              style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 18,
                      color:Colors.white
                    ),),
          
             ),

             ListTile(
              tileColor: Colors.black,
              leading:Icon(Ionicons.locate,color: Colors.white),
              title: Text('${_city}',
              style: GoogleFonts.poppins(
                      fontWeight:FontWeight.bold,
                      fontSize: 18,
                      color:Colors.white
                    ),),
          
             ),

             Spacer(),






          ],
        ),
      ),
    );
  }
}