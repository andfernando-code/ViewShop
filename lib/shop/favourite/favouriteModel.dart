import 'package:flutter/material.dart';
import 'package:shopnest/model/productModel.dart'; 


class FavoriteItem {
  final Product product; 

  
  FavoriteItem({required this.product});
}


class Favorite extends ChangeNotifier {
  final List<FavoriteItem> _items = []; 
 
 
  void addFavorite(Product product) {
   
    if (!_items.any((item) => item.product.itemID == product.itemID)) {
      _items.add(FavoriteItem(product: product));
      notifyListeners(); 
    }
  }

  
  void removeFavorite(Product product) {
    _items.removeWhere((item) => item.product.itemID == product.itemID);
    notifyListeners(); 
  }

  
  bool isFavorite(Product product) {
    return _items.any((item) => item.product.itemID == product.itemID);
  }

  
  List<FavoriteItem> getFavoriteItems() {
    return List<FavoriteItem>.from(_items);
  }

  
  void clearFavorites() {
    _items.clear();
    notifyListeners(); 
  }
}
