part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsInitialFetchEvent extends PostsEvent {}

class PostsProductUpdateButtonClickedEvent extends PostsEvent{
  final ProductDataModel maProduct;
  PostsProductUpdateButtonClickedEvent({required this.maProduct});
}

class PostsProductTransactionButtonClickedEvent extends PostsEvent{
  final ProductDataModel maProduct;
  PostsProductTransactionButtonClickedEvent({required this.maProduct});
}

class PostsAddButtonClickedEvent extends PostsEvent {}

class PostsAddSubmitButtonClickedEvent extends PostsEvent {
  final ProductDataModel addProduct;
  PostsAddSubmitButtonClickedEvent({required this.addProduct});
}

class PostsUpdateSubmitButtonClickedEvent extends PostsEvent {
  final ProductDataModel updatedProduct;
  PostsUpdateSubmitButtonClickedEvent({required this.updatedProduct});
}

class PostsTransactionSubmitButtonClickedEvent extends PostsEvent {
  final ProductDataModel updatedProduct;
  PostsTransactionSubmitButtonClickedEvent({required this.updatedProduct});
}

class PostsWishlistButtonNavigateEvent extends PostsEvent{}

