part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  bool? isWishListIconChanged;
  HomeLoadedSuccessState({
    required this.products,
  this.isWishListIconChanged});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductWishListColorChngState extends HomeActionState {
  bool? wishListColored;
  HomeProductWishListColorChngState(this.wishListColored);
}

class HomeProductItemCartedActionState extends HomeActionState {}
