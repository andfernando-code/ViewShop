
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopNestLoader extends StatelessWidget {
  const ShopNestLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        children: [
          SizedBox(height: 300,),
          Text('ViewShop',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 35.0,
              fontWeight: FontWeight.bold
            ),)
        ],
      )
      );
  }
}
