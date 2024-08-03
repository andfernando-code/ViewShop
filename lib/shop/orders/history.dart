import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/shop/orders/orderDetails.dart';




class Order {
  final String id;
  final double total;
  final String snapId;

  Order({required this.id, required this.total, required this.snapId});
}

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History',
        style: GoogleFonts.poppins(
          fontWeight:FontWeight.bold,
          fontSize:20
        ),),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getOrderHistory(),
          builder: (context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: Colors.black,
                
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Order> orders = snapshot.data ?? [];
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  Order order = orders[index];
                 
                  return GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderHistoryDetailsPage(orderId: order.snapId)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                      child: ListTile(
                        
                        title: Text('Order ID: ${order.id}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize:20
                        ),),
                        subtitle: Text('Total: \Rs: ${order.total.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontWeight:FontWeight.bold,
                          fontSize:20,
                          color: Colors.white
                        ),),
                        trailing: Icon(Ionicons.chevron_forward, color: Colors.white,size: 35,))
                        
                      ),
                    
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Order>> getOrderHistory() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;
    if (userEmail == null) {
      // User is not logged in
      return [];
    }

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('userEmail', isEqualTo: userEmail)
          .orderBy('createdAt', descending: true) // Order by creation date, newest first
          .get();

      List<Order> orders = querySnapshot.docs.map((doc) {
        return Order(
          id: doc['orderId'].toString(),
          snapId: doc.id, 
          total: doc['total'],
          
        );
      }).toList();

      return orders;
    } catch (e) {
      // Handle any errors
      print('Error fetching order history: $e');
      return [];
    }
  }
}
