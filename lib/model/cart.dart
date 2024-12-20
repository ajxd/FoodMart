import 'package:foodmart/model/culinarycreation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  CulinaryCreation creation;
  int quantity;

  CartItem(this.creation, this.quantity);

  Map<String, dynamic> toJson() => {
    'creation': creation.toJson(),
    'quantity': quantity,
  };

  static CartItem fromJson(Map<String, dynamic> json) => CartItem(
    CulinaryCreation.fromJson(json['creation']),
    json['quantity'],
  );
}

class Cart {
  Map<String, CartItem> items = {};

  void addItem(CulinaryCreation item) {
    if (items.containsKey(item.creationId)) {
      items[item.creationId]!.quantity++;
    } else {
      items[item.creationId] = CartItem(item, 1);
    }
    saveCartItems();
  }

  void removeItem(String creationId) {
    if (items.containsKey(creationId) && items[creationId]!.quantity > 1) {
      items[creationId]!.quantity--;
    } else {
      items.remove(creationId);
    }
    saveCartItems();
  }

  double getTotalPrice() {
    return items.values.fold(0, (total, item) => total + item.creation.costEstimation * item.quantity);
  }

  void clearCart() {
    items.clear();
    saveCartItems();
  }

  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items.map((id, item) => MapEntry(id, item.toJson()));
    await prefs.setString('cart_items', json.encode(itemsJson));
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart_items');
    if (cartData != null) {
      Map<String, dynamic> deserializedItems = json.decode(cartData);
      items = deserializedItems.map((id, itemData) => MapEntry(id, CartItem.fromJson(itemData)));
    }
  }
}
