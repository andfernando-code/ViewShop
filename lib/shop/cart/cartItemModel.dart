import 'package:flutter/material.dart';
import 'package:shopnest/model/productModel.dart'; // Importing the Product model

// Define a CartItem class to represent items in the cart
class CartItem {
  final Product product; // The product being added to the cart
  final int quantity; // The quantity of the product

  // Constructor for CartItem
  CartItem({required this.product, required this.quantity});

  // Method to calculate total price for the item
  double getTotalPrice() {
    return product.price * quantity;
  }
}

// The Cart class manages the cart items and provides methods to add, remove, and retrieve items
class Cart extends ChangeNotifier {
  final List<CartItem> _items = []; // List to store cart items

  // Method to add an item to the cart
  void addItem(Product product, int quantity) {
    var existingItemIndex =
        _items.indexWhere((item) => item.product.itemID == product.itemID);
    if (existingItemIndex != -1) {
      // If the product is already in the cart, update its quantity
      var existingItem = _items[existingItemIndex];
      _items[existingItemIndex] = CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + quantity);
    } else {
      // If the product is not in the cart, add it
      _items.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners(); // Notify listeners that the cart has been updated
  }

  // Method to remove an item from the cart
  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.itemID == product.itemID);
    notifyListeners(); // Notify listeners that the cart has been updated
  }

  // Method to get all items in the cart
  List<CartItem> getItems() {
    return List<CartItem>.from(_items);
  }

  // Method to calculate total price of all items in the cart
  double getFullTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _items) {
      totalPrice += item.getTotalPrice();
    }
    return totalPrice;
  }

void clear() {
    _items.clear();
  }

}
