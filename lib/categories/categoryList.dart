import 'package:flutter/material.dart';
import 'package:shopnest/categories/categoryCardProducts.dart';
import 'package:shopnest/model/category.dart';

class CategoryProductList extends StatelessWidget {
  const CategoryProductList({
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(
                      categories[index].image,
                      
                    ))
                  ),
                ),

                SizedBox(height: 10,),
                
                
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
