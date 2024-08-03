import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProductPageTop extends StatelessWidget {
  const ProductPageTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15)
            ),
            icon: Icon(Ionicons.chevron_back)
            ),
            const Spacer(),
    
            IconButton(
            onPressed: (){}, 
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15)
            ),
            icon: Icon(Ionicons.share_social_outline)
            ),
    
            SizedBox(width: 5,),
    
            IconButton(
            onPressed: (){}, 
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15)
            ),
            icon: Icon(Ionicons.heart_outline)
            ),
    
        ],
      ),
    );
  }
}