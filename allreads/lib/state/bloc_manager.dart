import 'package:allreads/models/novel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ToggleNovel extends WishlistEvent {
  final Novel novel;
  ToggleNovel(this.novel);
  @override
  List<Object> get props => [novel];
}

class WishlistState extends Equatable {
  final List<Novel> wishlist;
  const WishlistState(this.wishlist);
  @override
  List<Object> get props => [wishlist];
}

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistState([])) {
    on<ToggleNovel>((event, emit) {
      final updatedList = List<Novel>.from(state.wishlist);
      if (updatedList.contains(event.novel)) {
        updatedList.remove(event.novel);
      } else {
        updatedList.add(event.novel);
      }
      emit(WishlistState(updatedList));
    });
  }
}