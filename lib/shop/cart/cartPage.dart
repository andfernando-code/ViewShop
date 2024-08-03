import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopnest/shop/cart/cartItemModel.dart';
import 'package:shopnest/shop/cart/models/cartProvider.dart';
import 'package:shopnest/shop/checkout/checkout.dart';
import 'package:shopnest/shop/pages/main_screen.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartItem> cartItems = cartProvider.getItems();

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          'ViewShop Cart',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text('Your Cart Is Empty!',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight:FontWeight.bold,
                      fontSize: 25,
                    ),),

                    SizedBox(height: 10,),



                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainBottom()));
                    },
                    child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                    margin: const EdgeInsets.all(10),
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                    child: Center(
                      child: Text('Shop Now',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight:FontWeight.bold,
                        fontSize: 25,
                      ),),
                    ),
                                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartItems[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          cartProvider.removeItem(item.product);
                        },
                        child: ListTile(
                          title: Text(item.product.itemName,
                          style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight:FontWeight.bold,
                                  fontSize: 20,
                                ),),
                          subtitle: Text('Quantity: ${item.quantity}',
                                          style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 16,
                                    ),),
                          trailing: Text("\Rs: ${item.getTotalPrice().toString()}",
                                        style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight:FontWeight.bold,
                                    fontSize: 25,
                                  ),),
                        ),
                      );
                    },
                  ),
                ),

                
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                    margin: const EdgeInsets.all(10),
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                    child: Center(
                      child: Text('Go To Checkout',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight:FontWeight.bold,
                        fontSize: 25,
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                
              ],
            ),
    );
  }
}
