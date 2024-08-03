import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/auth/login.dart';
import 'package:shopnest/shop/contact.dart';
import 'package:shopnest/shop/favourite/favourite.dart';
import 'package:shopnest/shop/orders/history.dart';
import 'package:shopnest/user/addressInfo.dart';
import 'package:shopnest/user/profile.dart';
import 'package:shopnest/widgets/loader.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<DocumentSnapshot> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = getInfo();
  }

  Future<DocumentSnapshot> getInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    return FirebaseFirestore.instance.collection('Users').doc(uid).get();
  }

  Future _signOut()async{
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
  }

  String getCurrentUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.email ?? ''; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: FutureBuilder<DocumentSnapshot>(

          future: userInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShopNestLoader();

            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;

              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    // Profile photo
                    CircleAvatar(
                      radius: 50.0,
                      child: Image.asset('assets/profile/profile.png'),
                    ),
                    SizedBox(height: 20.0),
                
                    // User name
                    Text(
                      '${userData!['name']}',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight:FontWeight.bold,
                        color:Colors.black
                      ),
                    ),
                    // User email
                    Text(
                      '${userData['email']}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight:FontWeight.bold,
                        color:Colors.black
                      ),
                    ),
                    SizedBox(height: 20.0),
                
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                         
                          
                          children: [
                        
                            Spacer(),
                        
                          ListTile(
                            tileColor: Colors.black,
                            leading: Icon(Ionicons.heart,color: Colors.white),
                            title: Text('Favourite',
                            style: GoogleFonts.poppins(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color:Colors.white
                                  ),),
                            trailing: Icon(Ionicons.eye_outline,color: Colors.white),
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FavoritePage()),
                                    );
                                              },
                          ),
                          
                          ListTile(
                            tileColor: Colors.black,
                            leading: Icon(Ionicons.bag_check,color: Colors.white),
                            title: Text('Order History',
                            style: GoogleFonts.poppins(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color:Colors.white
                                  ),),
                            trailing: Icon(Ionicons.eye_outline,color: Colors.white),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderHistoryPage()));
                            },
                          ),


                          ListTile(
                            tileColor: Colors.black,
                            leading: Icon(Ionicons.person,color: Colors.white),
                            title: Text('Profile Details',
                            style: GoogleFonts.poppins(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color:Colors.white
                                  ),),
                            trailing: Icon(Ionicons.create_outline,color: Colors.white),
                            onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            },
                          ),
                        
                          ListTile(
                            tileColor: Colors.black,
                            leading: Icon(Ionicons.headset,color: Colors.white),
                            title: Text('Customer Care',
                            style: GoogleFonts.poppins(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color:Colors.white
                                  ),),
                            trailing: Icon(Ionicons.call_outline,color: Colors.white),
                            onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactNow() ));
                            },
                          ),
                        
                          ListTile(
                            tileColor: Colors.black,
                            leading: Icon(Ionicons.location,color: Colors.white),
                            title: Text('Address Information',
                            style: GoogleFonts.poppins(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color:Colors.white
                                  ),),
                            trailing: Icon(Ionicons.chevron_forward,color: Colors.white),
                            onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressInformationPage()));
                            },
                          ),
                        
                          ListTile(
                            tileColor: Colors.black,
                            leading: Icon(Ionicons.exit,color: Colors.white),
                            title: Text('Logout',
                            style: GoogleFonts.poppins(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color:Colors.white
                                  ),),
                           
                            onTap: _signOut,
                          ),
                        
                          Spacer(),
                        
                        ],),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
