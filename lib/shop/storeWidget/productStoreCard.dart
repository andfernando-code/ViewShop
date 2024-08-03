import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/model/productModel.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/shop/pages/productPage.dart';


class ProductListCard extends StatelessWidget {
  final Product product;
  const ProductListCard({super.key, required this.product});
  
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ProductPage(product: product))));
      },
      child: Stack(
        children:[
          Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all()
          ),
          child: Column(
            children: [
              Image.asset(
                product.image,
                width: 120,
                height: 120,
                ),
              Text(
                product.itemName,
                style: GoogleFonts.poppins(
                  fontWeight:FontWeight.bold,
                  fontSize:18,
                ),
                ),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("\Rs: ${product.price}",
                  style: GoogleFonts.poppins(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),

                  Icon(Ionicons.eye)
                  
                ],
              ),
            ],
          ),
        ),
      
        Positioned.fill(child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10)
              )
            ),
            child: IconButton(
              onPressed: (){},
              
              
              icon: Icon(Ionicons.heart_outline, size: 18,color: Colors.white,)
              ),
          ),
        )),
        ] 
      ),
    );
  }
}