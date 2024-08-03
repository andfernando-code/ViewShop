import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/categories/categoryCardProducts.dart';
import 'package:shopnest/model/category.dart';

class ShopNestCategories extends StatelessWidget {
  const ShopNestCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CategoryCardProducts(categoryName: categories[index].title)));
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(
                      categories[index].image,
                      
                    ))
                  ),
                ),
                SizedBox(height: 5,),
                Text(categories[index].title,
                style: GoogleFonts.poppins(
                  fontWeight:FontWeight.bold,
                )),
                
              ],
            ),
          );
        }, 
        separatorBuilder: (context, index)=> const SizedBox(width: 20), 
        itemCount: categories.length,
        ),
    );
  }
}
