import 'package:flutter/foundation.dart';

/// Service reaktif untuk mengelola jumlah dan item keranjang belanja.
class CartService {
  CartService._();
  static final CartService instance = CartService._();

  /// Reactive notifier untuk total item di keranjang
  final ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  int get count => cartCount.value;

  /// Menambah item ke keranjang
  void addItem({int quantity = 1}) {
    if (quantity > 0) {
      cartCount.value += quantity;
    }
  }

  /// Mengurangi item dari keranjang
  void removeItem({int quantity = 1}) {
    if (cartCount.value >= quantity) {
      cartCount.value -= quantity;
    } else {
      cartCount.value = 0;
    }
  }

  /// Mengatur langsung jumlah item keranjang
  void setCount(int newCount) {
    cartCount.value = newCount >= 0 ? newCount : 0;
  }

  /// Mengosongkan keranjang
  void clearCart() {
    cartCount.value = 0;
  }
}
