part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistNavigateState extends WishlistActionState {}
