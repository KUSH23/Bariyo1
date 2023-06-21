part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistProductButtonClickedEvent extends WishlistEvent{
  final ProductDataModel maProduct;
  WishlistProductButtonClickedEvent({required this.maProduct});
}