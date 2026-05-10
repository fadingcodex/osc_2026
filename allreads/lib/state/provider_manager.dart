import 'package:allreads/models/novel.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Novel> _wishlist = [];
  List<Novel> get wishlist => _wishlist;

  void toggleWishlist(Novel novel) {
    final isExist = _wishlist.contains(novel);
    if (isExist) {
      _wishlist.remove(novel);
    } else {
      _wishlist.add(novel);
    }
    notifyListeners();
  }

  bool isFavorite(Novel novel) => _wishlist.contains(novel);
}