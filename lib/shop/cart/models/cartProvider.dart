import 'package:flutter/material.dart';
import 'package:shopnest/model/productModel.dart';
import 'package:shopnest/shop/cart/cartItemModel.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();

  void addItem(Product product, int quantity) {
    _cart.addItem(product, quantity);
    notifyListeners();
  }

  

  void removeItem(Product product) {
    _cart.removeItem(product);
    notifyListeners();
  }

  List<CartItem> getItems() {
    return _cart.getItems();
  }

    void clearCart() {
    
    _cart.clear();
    notifyListeners();
  }
  

 
  double getFullTotalPrice() {
    double totalPrice = 0.0;
    List<CartItem> items = _cart.getItems(); 
    for (var item in items) {
      totalPrice += item.getTotalPrice();
    }
    return totalPrice;
  }

 

 

}
