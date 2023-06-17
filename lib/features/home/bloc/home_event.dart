part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class HomeProductWishlistButtonClickedEvent extends HomeEvent{}

class HomeProductCartButtonClickedEvent extends HomeEvent{
  final ProductTransDataModel addedProduct;
  HomeProductCartButtonClickedEvent({required this.addedProduct});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent{}

class HomeCartButtonNavigateEvent extends HomeEvent{}