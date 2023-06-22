part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedSuccessState extends WishlistState {
  ProductDataModel maProduct;
  WishlistLoadedSuccessState({required this.maProduct});
}

class WishlistNavigateState extends WishlistActionState {}
