import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopnest/shop/cart/models/cartProvider.dart';
import 'package:shopnest/shop/checkout/thankYou.dart';

int generateOrderID() {
  Random random = Random();
  return random.nextInt(9000) + 1000; 
}

enum PaymentMethod {
  card,
  cod,
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.card;
  bool _useExistingAddress = false;
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expirationDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  List<String> existingAddresses = []; 

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    double totalPrice = cartProvider.getFullTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ViewShop Pay',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Payment Details:',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Use Existing Address:',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: _useExistingAddress,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _useExistingAddress = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              _useExistingAddress ? _buildAddressDropdown() : _buildAddressInputFields(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Method:',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  DropdownButton<PaymentMethod>(
                    value: _selectedPaymentMethod,
                    onChanged: (PaymentMethod? newValue) {
                      setState(() {
                        _selectedPaymentMethod = newValue!;
                      });
                    },
                    items: PaymentMethod.values
                        .map((paymentMethod) => DropdownMenuItem<PaymentMethod>(
                      value: paymentMethod,
                      child: Text(paymentMethodToString(paymentMethod)),
                    ))
                        .toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_selectedPaymentMethod == PaymentMethod.card) ...[
                SizedBox(height: 20),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _expirationDateController,
                  decoration: InputDecoration(
                    labelText: 'Expiration Date',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _cvvController,
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Total: \Rs ${totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // PayNow Button
              GestureDetector(
                onTap: () async {
                  final CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

                  if (_useExistingAddress) {
                    _addressController.clear();
                    _zipCodeController.clear();
                    _cityController.clear();
                    _phoneNumberController.clear();
                  }

                  _sendShippingDetailsToFirebase();
                  await _sendOrderToFirestore();

                  cartProvider.clearCart();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ThankYou()),
                  );
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    margin: const EdgeInsets.all(10),
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        'Pay My Bill',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressDropdown() {
    return DropdownButton<String>(
      value: existingAddresses.isNotEmpty ? existingAddresses.first : null,
      onChanged: (String? newValue) {
        setState(() {
          // Handle dropdown value change if needed
        });
      },
      items: existingAddresses.map((address) {
        return DropdownMenuItem<String>(
          value: address,
          child: Text(address),
        );
      }).toList(),
    );
  }

  Widget _buildAddressInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _zipCodeController,
          decoration: InputDecoration(
            labelText: 'Zip Code',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _cityController,
          decoration: InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _phoneNumberController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _sendShippingDetailsToFirebase() async {
  if (_useExistingAddress) {
    
    return;
  }

  String address = _addressController.text;
  String zipCode = _zipCodeController.text;
  String city = _cityController.text;
  String phoneNumber = _phoneNumberController.text;

  User? user = FirebaseAuth.instance.currentUser;
  String? userEmail = user?.email;

  if (userEmail != null) {
    Map<String, dynamic> shippingData = {
      'userEmail': userEmail,
      'address': address,
      'zipCode': zipCode,
      'city': city,
      'phoneNumber': phoneNumber,
    };

    try {
      await FirebaseFirestore.instance.collection('Shipping_details').add(shippingData);
      print('Shipping details added to Firestore successfully');
    } catch (error) {
      print('Error adding shipping details to Firestore: $error');
    }
  } else {
    print('User is not logged in');
  }
}


  Future<void> _sendOrderToFirestore() async {
    final CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    if (userEmail != null) {
      List<Map<String, dynamic>> items = cartProvider.getItems().map((item) {
        return {
          'itemName': item.product.itemName,
          'quantity': item.quantity,
          'price': item.product.price,
        };
      }).toList();

      // Generate a random 4-digit number for the order ID
      int orderId = generateOrderID();

      double total = cartProvider.getFullTotalPrice();

      Map<String, dynamic> orderData = {
        'orderId': orderId,
        'userEmail': userEmail,
        'items': items,
        'total': total,
        'paymentMethod': paymentMethodToString(_selectedPaymentMethod),
        'address': _addressController.text,
        'zipCode': _zipCodeController.text,
        'city': _cityController.text,
        'phoneNumber': _phoneNumberController.text,
        'createdAt': FieldValue.serverTimestamp(),
      };

      try {
        await FirebaseFirestore.instance.collection('Orders').add(orderData);
        print('Order details added to Firestore successfully');
      } catch (error) {
        print('Error adding order details to Firestore: $error');
      }
    } else {
      print('User is not logged in');
    }
  }

  String paymentMethodToString(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return 'Credit/Debit Card';
      case PaymentMethod.cod:
        return 'Cash on Delivery';
    }
  }
}
