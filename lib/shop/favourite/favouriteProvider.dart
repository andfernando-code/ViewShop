import 'package:flutter/material.dart';
import 'package:shopnest/model/productModel.dart';
import 'package:shopnest/shop/favourite/favouriteModel.dart';

class FavoriteProvider extends ChangeNotifier {
  final Favorite _favorite = Favorite(); 
  
  // Method to add an item to favorites
  void addFavorite(Product product) {
    _favorite.addFavorite(product);
    notifyListeners();
  }

  // Method to remove an item from favorites
  void removeFavorite(Product product) {
    _favorite.removeFavorite(product);
    notifyListeners();
  }

  // Method to check if an item is already in favorites
  bool isFavorite(Product product) {
    return _favorite.isFavorite(product);
  }

  // Method to get all items in favorites
  List<FavoriteItem> getFavoriteItems() {
    return _favorite.getFavoriteItems();
  }

  // Method to clear all items from favorites
  void clearFavorites() {
    _favorite.clearFavorites();
    notifyListeners();
  }

  
}
