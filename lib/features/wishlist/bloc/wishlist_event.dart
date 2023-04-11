part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}



class WishlistRemoveFromItm extends WishlistEvent {
final ProductDataModel productDataModel;

  WishlistRemoveFromItm(this.productDataModel);
}


class WishListDeleteAllItem extends WishlistEvent {
}

class WishListLongPressItem extends WishlistEvent {

}




