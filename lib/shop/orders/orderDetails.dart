import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Order {
  final String oID;
  final double oTotal;
  final String payment;
  final List<Map<String, dynamic>> items;

  Order({required this.oID, required this.oTotal, required this.items, required this.payment});
}

class OrderHistoryDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderHistoryDetailsPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History Details',
        style: GoogleFonts.poppins(
          fontWeight:FontWeight.bold,
          fontSize:20
        ),),
      ),
      body: FutureBuilder<Order>(
        future: getOrderDetails(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Order order = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Order Name Id


                Center(
                  child: Card(
                    elevation: 4,
                    
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                       
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID: ${order.oID}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total: \Rs ${order.oTotal.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Method: ${order.payment.toString()}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),





                SizedBox(height: 10),

                //Orderd items

                Center(
                  child: Text(
                    'Order Items:',
                    style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight:FontWeight.bold,
                          fontSize:20
                        ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      var item = order.items[index];
                      return
                      
                       ListTile(
                        title: Text(item['itemName'],
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight:FontWeight.bold,
                          fontSize:18
                        ),),
                        subtitle: Text('Quantity: ${item['quantity']}',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight:FontWeight.bold,
                          fontSize:16
                        ),),
                        trailing: Text('\Rs ${item['price']}',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight:FontWeight.bold,
                          fontSize:18
                        ),),
                      );


                      
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Order> getOrderDetails(String orderId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> orderSnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .get();

      if (orderSnapshot.exists) {
        // Order found, extract data and return Order object
        Map<String, dynamic> data = orderSnapshot.data()!;
        List<Map<String, dynamic>> items = List.from(data['items']);
        Order myOrder = Order(
          oID: data['orderId'].toString(),
          oTotal: data['total'],
          payment: data['paymentMethod'],
          items: items,
          // Add more properties as needed
        );
        return myOrder;
      } else {
        throw Exception('Order not found');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching order details: $e');
      throw e; // Rethrow the error to the caller
    }
  }
}
