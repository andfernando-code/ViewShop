import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/model/productModel.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  const ProductDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Text('Description',
                      style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight:FontWeight.bold,
                    ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(product.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight:FontWeight.bold,
                    ),),
      ],
    );
  }
}