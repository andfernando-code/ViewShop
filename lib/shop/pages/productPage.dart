import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shopnest/model/productModel.dart';
import 'package:shopnest/shop/cart/cartItemModel.dart';
import 'package:shopnest/shop/cart/models/cartProvider.dart';
import 'package:shopnest/shop/favourite/favouriteProvider.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
 
  int currentNumber = 1;
  Cart cart = Cart();
  
  
  @override
  Widget build(BuildContext context) {

   


    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(15)
            ),
            icon: Icon(Ionicons.chevron_back,size: 30,)
            ),
        actions: [
          IconButton(
            onPressed: (){}, 
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(15)
            ),
            icon: Icon(Ionicons.share_social_outline,size: 30,)
            ),
    
            SizedBox(width: 5,),
    
            //Favourite Page

            IconButton(
                onPressed: () {
                 
                  setState(() {
                    widget.product.isFavorite = !widget.product.isFavorite;
                  });
                  
                  if (widget.product.isFavorite) {
                    Provider.of<FavoriteProvider>(context, listen: false)
                        .addFavorite(widget.product);
                  } else {
                    Provider.of<FavoriteProvider>(context, listen: false)
                        .removeFavorite(widget.product);
                  }
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(15),
                ),
                icon: Icon(
                  widget.product.isFavorite ? Ionicons.heart : Ionicons.heart_outline,
                  size: 30,
                  color: widget.product.isFavorite ? Colors.red : Colors.black,
                ),
              ),

        ],
      ),

      //add to card float button
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: AddToCardFloat(
            cart: cart,
            currentNumber: currentNumber,
            onAdd: () {
              setState(() {
                currentNumber++;
              });
            },
            onRemove: () {
              setState(() {
                if (currentNumber > 1) {
                  currentNumber--;
                }
              });
            },
            product: widget.product, 
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,



      // backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                height: 300,
                width: 500,
                child: Image.asset(widget.product.image,
                ),
              ),
        
        
             ///Future Implements for more images like product variations by variations
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(
              //     4, 
              //     (index) => AnimatedContainer(
              //       duration: const Duration(milliseconds: 300,),
              //       width: 8,
              //       height: currentImage == index?15:8,
              //       margin: EdgeInsets.only(right: 2),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: currentImage==index? Colors.black : Colors.white ,
              //         border: Border.all(color: Colors.black)
              //       ), 
              //       ),
              //     ),
              //   ),
        
        
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                    ),
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    //product name,price,rate
                   Text(widget.product.itemName,
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
                      Text("\Rs: ${widget.product.price}",
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
                                Text("${widget.product.reviewRate}")
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
                        
                    //product colors
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Colors:',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:FontWeight.bold,
                        ),),


                        SizedBox(width: 10,),
                        Container(
                              width: 35,
                              height: 35,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                 color: Color(widget.product.colors[0].hashCode),
                                
                              ),
                              child: Container(
                                width: 25,
                                height: 25,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(widget.product.colors[0].hashCode),
                                

                              ),
                              ),
                            ),
                        
                      ],
                    ),
                    
                        
                    SizedBox(height: 20),
                    //product description
                        
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
                    Text(widget.product.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight:FontWeight.bold,
                    ),),

                    
                        
                   
                        
                  ],
                                ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}

// add to cart option
class AddToCardFloat extends StatelessWidget {
  final Function() onAdd;
  final Function() onRemove;
  final int currentNumber;
  final Cart cart;
  final Product product;

  const AddToCardFloat({
    Key? key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
    required this.cart,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: onRemove,
                  iconSize: 18,
                  icon: Icon(Ionicons.remove),
                ),
                SizedBox(width: 5,),
                Text(currentNumber.toString()),
                SizedBox(width: 5,),
                IconButton(
                  onPressed: onAdd,
                  iconSize: 18,
                  icon: Icon(Ionicons.add),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
        
              cartProvider.addItem(product, currentNumber);
            
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product added to cart'),
                  duration: Duration(milliseconds: 50),
                  ),
                
              );
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                'Add to Cart',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          

        ],
      ),
    );
  }
}
