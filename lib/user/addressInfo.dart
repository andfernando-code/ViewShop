import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressInformationPage extends StatefulWidget {
  @override
  _AddressInformationPageState createState() => _AddressInformationPageState();
}

class _AddressInformationPageState extends State<AddressInformationPage> {
  List<DocumentSnapshot> _addressSnapshots = [];

  @override
  void initState() {
    super.initState();
    _loadAddressDetails();
  }

  void _loadAddressDetails() async {
    
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail != null) {
      try {
      
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Shipping_details')
            .where('userEmail', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
         
          setState(() {
            _addressSnapshots = querySnapshot.docs;
          });
        } else {
          
          print('Address details not found in Firestore');
        }
      } catch (error) {
        print('Error loading address details: $error');
       
      }
    } else {
      print('User is not logged in');
    }
  }

  Future<void> _deleteAddress(String addressId) async {
    try {
      await FirebaseFirestore.instance.collection('Shipping_details').doc(addressId).delete();
     
      setState(() {
        _addressSnapshots.removeWhere((snapshot) => snapshot.id == addressId);
      });
    } catch (error) {
      print('Error deleting address: $error');
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Information',
        style: GoogleFonts.poppins(
          fontWeight:FontWeight.bold,
          fontSize:20,
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: _addressSnapshots.isEmpty
            ? Center(child: Text('No addresses found',
            style: GoogleFonts.poppins(
                                fontWeight:FontWeight.bold,
                                fontSize:20,
                              ),))
            : ListView.builder(
                itemCount: _addressSnapshots.length,
                itemBuilder: (context, index) {
                  final addressSnapshot = _addressSnapshots[index];
                  final addressData = addressSnapshot.data() as Map<String, dynamic>;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping Address ${index + 1}:',
                          style: GoogleFonts.poppins(
                                  fontWeight:FontWeight.bold,
                                  fontSize:20,
                                  color:Colors.white
                                ),
                        ),
                        SizedBox(height: 20),
                        Text('Address: ${addressData['address']}',
                        style: GoogleFonts.poppins(
                                  fontWeight:FontWeight.bold,
                                  fontSize:16,
                                  color:Colors.white
                                ),),
                        SizedBox(height: 10),
                        Text('Zip Code: ${addressData['zipCode']}',
                        style: GoogleFonts.poppins(
                                  fontWeight:FontWeight.bold,
                                  fontSize:16,
                                  color:Colors.white
                                ),),
                        SizedBox(height: 10),
                        Text('City: ${addressData['city']}',
                        style: GoogleFonts.poppins(
                                  fontWeight:FontWeight.bold,
                                  fontSize:16,
                                  color:Colors.white
                                ),),
                        SizedBox(height: 10),
                        Text('Phone Number: ${addressData['phoneNumber']}',
                        style: GoogleFonts.poppins(
                                  fontWeight:FontWeight.bold,
                                  fontSize:16,
                                  color:Colors.white
                                ),),
                        SizedBox(height: 15),

                        Center(
                          child: GestureDetector(
                            onTap: () => _deleteAddress(addressSnapshot.id),
                            child: Container(
                              height: 30,
                             
                              decoration: BoxDecoration(
                                color: Colors.white
                              ),
                              width: 100,
                              child: Center(child: Text('Delete ',
                              style: GoogleFonts.poppins(
                                  fontWeight:FontWeight.bold,
                                  fontSize:16,
                                ),))
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
