part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishListActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishListEmptyState extends WishlistState {}

class WishListItemRemoveState extends WishlistState {}




class WishListSuccessStae extends WishlistState {
  final List<ProductDataModel> wishlistItems;
  WishListSuccessStae({required this.wishlistItems});
}

class WishListDeleteAllItemState extends WishlistState {}


class WishListLongPressItemState extends WishlistState {}



