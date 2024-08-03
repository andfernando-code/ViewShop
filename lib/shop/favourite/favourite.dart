import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopnest/shop/favourite/favouriteModel.dart';
import 'package:shopnest/shop/favourite/favouriteProvider.dart';



class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);
    List<FavoriteItem> favoriteItems = favoriteProvider.getFavoriteItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Items',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: favoriteItems.isEmpty
          ? SafeArea(
            child: Column(
               children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(50),
                  child: Text(
                    'No favorite items yet!',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          )
          : ListView.builder(
  itemCount: favoriteItems.length,
  itemBuilder: (context, index) {
    var item = favoriteItems[index];
    return Dismissible(
      key: Key(item.product.itemID), 
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        
        favoriteProvider.removeFavorite(item.product);
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.product.itemName} removed from favorites'),
            duration: Duration(milliseconds: 50),
          ),
        );
      },
      child: ListTile(
        title: Text(
          item.product.itemName,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'Price: \Rs${item.product.price.toString()}',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  },
),

    );
  }
}
