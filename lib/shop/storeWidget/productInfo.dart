import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/model/productModel.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
               
                  Text(product.itemName,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight:FontWeight.bold,
                  ),
                  ),
         Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\Rs: ${product.price}",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:FontWeight.bold,
                      ),
                      ),
                      SizedBox(width: 10,),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Icon(Ionicons.star, size: 15,color: Colors.black,),
                                Text("${product.reviewRate}")
                              ],
                            ),
                          ),

                          SizedBox(width: 5,),
                          Text("(320+ Reviews)",
                          style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight:FontWeight.bold,
                              ),
                              ),
                        ],
                      ),
                    ],
                  ),
                
      ],
    );
  }
}