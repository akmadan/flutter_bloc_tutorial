import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_tutorial/data/grocery_data.dart';
import 'package:flutter_bloc_tutorial/data/wishlist_items.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc? wishlistBloc;
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
    log(event.productDataModel.isWishListed.toString());
    String id = event.productDataModel.id;
    GroceryData.groceryProducts.forEach((element) {
      if (id == element['id']) {
        // GroceryData.groceryProducts[int.parse(id)- 1]['isWishListed'] = false;
   Home.productwidget![int.parse(id)-1].isWishListed = false;
   GroceryData.groceryProducts[int.parse(id)-1]["isWishListed"] = false;
      }
    });

    log("Id of remove item  from wishlist = ${GroceryData.groceryProducts[int.parse(id)- 1]}");

    wishlistItems.remove(event.productDataModel);

    emit(WishListItemRemoveState());

    emit(WishListSuccessStae(wishlistItems: wishlistItems));
    if (wishlistItems.length == 0) {
      emit(WishListEmptyState());
    }
  }

  FutureOr<void> wishListDeleteAllItem(
      WishListDeleteAllItem event, Emitter<WishlistState> emit) {
    wishlistItems.length == 0;
    emit(WishListEmptyState());
  }

  FutureOr<void> wishListLongPressItem(
      WishListLongPressItem event, Emitter<WishlistState> emit) {
    emit(WishListLongPressItemState());
  }
}
