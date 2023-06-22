import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mediafirst/controller/form_controller.dart';
import 'package:mediafirst/models/home_product.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);

    on<PostsProductTransactionButtonClickedEvent>(postsProductTransactionButtonClickedEvent);

    on<PostsAddSubmitButtonClickedEvent>(postsAddSubmitButtonClickedEvent);

    on<PostsUpdateSubmitButtonClickedEvent>(postsUpdateSubmitButtonClickedEvent);

    on<PostsProductUpdateButtonClickedEvent>(postsProductUpdateButtonClickedEvent);

    on<PostsTransactionSubmitButtonClickedEvent>(postsTransactionSubmitButtonClickedEvent);

    on<PostsAddButtonClickedEvent>(postsAddButtonClickedEvent);

    on<PostsProductButtonClickedEvent>(postsProductButtonClickedEvent);

    on<PostsSearchButtonClickedEvent>(postsSearchButtonClickedEvent);
  }

  Future<FutureOr<void>> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());

      List<ProductDataModel> mydata = await FormController().getProductsList("");
      emit(PostsLoadedSuccessState(products: mydata));
  }


  Future<FutureOr<void>> postsAddSubmitButtonClickedEvent(
      PostsAddSubmitButtonClickedEvent event, Emitter<PostsState> emit) async {
    bool success = await FormController().addProducts(product : event.addProduct);
    if(success){
      emit(PostsAdditionSuccessState());
    }else {
      emit(PostsAdditionErrorState());
    }
    // print(success);
  }

  FutureOr<void> postsUpdateSubmitButtonClickedEvent(
      PostsUpdateSubmitButtonClickedEvent event, Emitter<PostsState> emit) async {
    bool success = await FormController().updateProduct(product : event.updatedProduct);
    if(success){
      emit(PostsAdditionSuccessState());
    }else {
      emit(PostsAdditionErrorState());
    }
  }

  FutureOr<void> postsProductUpdateButtonClickedEvent(
      PostsProductUpdateButtonClickedEvent event, Emitter<PostsState> emit) async {
    print("Update button clicked!");
    // emit(PostsUpdateFormLoadingState());
    // await Future.delayed(const Duration(seconds: 2));
    emit(PostsUpdateFormState(product:event.maProduct));
  }

  FutureOr<void> postsAddButtonClickedEvent(
      PostsAddButtonClickedEvent event, Emitter<PostsState> emit) {
    print("Add button clicked!");
    emit(PostsAdditionState());
  }


  FutureOr<void> postsProductTransactionButtonClickedEvent(
      PostsProductTransactionButtonClickedEvent event, Emitter<PostsState> emit) {
    print("Transaction button clicked!");
    emit(PostsTransactionFormState(product:event.maProduct));
  }

  FutureOr<void> postsTransactionSubmitButtonClickedEvent(
      PostsTransactionSubmitButtonClickedEvent event, Emitter<PostsState> emit) {
  }

  FutureOr<void> postsProductButtonClickedEvent(
      PostsProductButtonClickedEvent event, Emitter<PostsState> emit) {
    print("navigate");
    emit(PostsProductDataFormState(product:event.maProduct));
  }

  FutureOr<void> postsSearchButtonClickedEvent(
      PostsSearchButtonClickedEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());

    List<ProductDataModel> mydata = await FormController().getProductsList("");
    List<ProductDataModel> filteredFeedbackItems = mydata
        .where((item) => item.itemname!.toLowerCase().contains(event.searchText.toLowerCase()))
        .toList();
    emit(PostsLoadedSuccessState(products: filteredFeedbackItems));
  }
}
