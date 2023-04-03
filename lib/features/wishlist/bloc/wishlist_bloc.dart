import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_tutorial/data/wishlist_items.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc? wishlistBloc ;
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromItm>(WishlistRemoveFromItmEvent);
    on<WishListDeleteAllItem>(wishListDeleteAllItem);
    on<WishListLongPressItem>(wishListLongPressItem);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(
      Duration(milliseconds: 800),
    );

    if (wishlistItems.length == 0) {
      emit(WishListEmptyState());
    } else {
      emit(WishListSuccessStae(wishlistItems: wishlistItems));
    }
  }

  FutureOr<void> WishlistRemoveFromItmEvent(
      WishlistRemoveFromItm event, Emitter<WishlistState> emit) {
        // event.productDataModel.isWishListed = false;

    wishlistItems.remove(event.productDataModel);
    
    emit(WishListItemRemoveState());

    emit(WishListSuccessStae(wishlistItems: wishlistItems));
    if (wishlistItems.length == 0) {
      emit(WishListEmptyState());
    } 
  }

  FutureOr<void> wishListDeleteAllItem(WishListDeleteAllItem event, Emitter<WishlistState> emit) {
    wishlistItems.length == 0;
emit(WishListEmptyState());
  }

  FutureOr<void> wishListLongPressItem(WishListLongPressItem event, Emitter<WishlistState> emit) {
    emit(WishListLongPressItemState());
   
  }
}
