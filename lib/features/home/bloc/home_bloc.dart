import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc/data/cart_items.dart';
import 'package:simple_bloc/data/fav_items.dart';
import 'package:simple_bloc/data/grocery_data.dart';
import 'package:simple_bloc/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //click event
    on<HomeIntialEvent>(homeIntialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    //navigate event
    on<HomeWishlistCartButtonNavigateEvent>(
        homeWishlistCartButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeIntialEvent(
      HomeIntialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(
      HomeLoadedSucessState(
          products: GroceryData.groceryProducts
              .map(
                (e) => ProductDataModel(
                  id: e['id'],
                  name: e['name'],
                  description: e['description'],
                  price: e['price'],
                  imageUrl: e['imageUrl'],
                ),
              )
              .toList()),
    );
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    // print("Wishlist Product Clicked");
    favItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    // print("Cart Product clicked");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistCartButtonNavigateEvent(
      HomeWishlistCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    // print("Wishlist Navigate clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    // print("Cart Navigate clicked");
    emit(HomeNavigateToCartPageActionState());
  }
}
