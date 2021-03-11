import 'package:flutter/material.dart';
import 'package:sokon/models/cartItems.dart';

class CartProvider with ChangeNotifier{
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  void addToCart(String productId, String title){
    if(_items.containsKey(productId)){
      _items.update(productId, (existingCartItem) => CartItems(
        id: existingCartItem.id,
        title: existingCartItem.title,
        productDescription: existingCartItem.productDescription,
        quantity: existingCartItem.quantity,
      ));
    }
    else{
      _items.putIfAbsent(productId, () => CartItems(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart(){
    _items = {};
    notifyListeners();
  }

}