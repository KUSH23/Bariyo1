part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedSuccessState extends PostsState {
  List<ProductDataModel> products;
  PostsLoadedSuccessState({required this.products});
}

class PostsErrorState extends PostsState {}

class PostsAdditionSuccessState extends PostsActionState {}

class PostsAdditionErrorState extends PostsActionState {}

class PostsTransactionAdditionSuccessState extends PostsActionState {}

class PostsUpdateFormState extends PostsActionState {
  ProductDataModel product;
  PostsUpdateFormState({required this.product});
}

class PostsTransactionFormState extends PostsActionState {
  ProductDataModel product;
  PostsTransactionFormState({required this.product});
}

class PostsAdditionState extends PostsActionState {}

class PostsProductDataFormState extends PostsActionState {
  ProductDataModel product;
  List<ProductTransDataModel> tproducts;
  PostsProductDataFormState({required this.product, required this.tproducts});
}