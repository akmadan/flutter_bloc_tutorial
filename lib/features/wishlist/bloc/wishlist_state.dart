part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> favItems;

  WishlistSuccessState({required this.favItems});
}
