import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc/data/fav_items.dart';
import 'package:simple_bloc/features/home/models/home_product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishListInitialEvent>(wishListInitialEvent);
    on<WishlistRemoveFromWishListEvent>(wishlistRemoveFromWishListEvent);
  }

  FutureOr<void> wishListInitialEvent(
      WishListInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(favItems: favItems));
  }

  FutureOr<void> wishlistRemoveFromWishListEvent(
      WishlistRemoveFromWishListEvent event, Emitter<WishlistState> emit) {
    favItems.remove(event.productDataModel);
    emit(WishlistSuccessState(favItems: favItems));
  }
}
