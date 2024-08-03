import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopnest/shop/cart/models/cartProvider.dart';
import 'package:shopnest/shop/cart/cartItemModel.dart';
import 'package:shopnest/shop/checkout/payment.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartItem> cartItems = cartProvider.getItems();
    double totalPrice = cartProvider.getFullTotalPrice(); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return ListTile(
                    title: Text(item.product.itemName,
                      style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                    subtitle: Text('Quantity: ${item.quantity}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                    trailing: Text("\Rs: ${item.getTotalPrice().toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                ),
                Text(
                  '\Rs: ${totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                ),
              ],
            ),
            SizedBox(height: 20),

            //Payment Button
            GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage()),
                    );
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                      child: Center(
                        child: Text('Proceed To Payment',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                          fontSize: 20,
                        ),),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
