import 'package:allreads/models/novel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistNotifier extends Notifier<List<Novel>> {
  @override
  List<Novel> build() => [];

  void toggle(Novel novel) {
    if (state.contains(novel)) {
      state = state.where((n) => n.id != novel.id).toList();
    } else {
      state = [...state, novel];
    }
  }
}

final wishlistProvider = NotifierProvider<WishlistNotifier, List<Novel>>(WishlistNotifier.new);