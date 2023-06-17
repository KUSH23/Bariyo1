import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediafirst/controller/form_controller.dart';
import 'package:mediafirst/data/cart_data.dart';
import 'package:mediafirst/data/test_data.dart';
import 'package:mediafirst/models/home_product.dart';
import 'package:mediafirst/models/transactionModel.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // on<HomeInitialEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<HomeInitialEvent>(
        homeInitialEvent
    );

    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent
    );

    on<HomeProductCartButtonClickedEvent>(
        homeProductCartButtonClickedEvent
    );

    on<HomeWishlistButtonNavigateEvent>(
        homeWishlistButtonNavigateEvent
    );

    on<HomeCartButtonNavigateEvent>(
        homeCartButtonNavigateEvent
    );
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    // await Future.delayed(const Duration(seconds: 3));
    List<ProductTransDataModel> mydata = await FormController().getProductsTransList(null);
    emit(HomeLoadedSuccessState(products: mydata));
    // emit(HomeLoadedSuccessState(
    //     products: TestData.spareProducts
    //         .map((e) => ProductDataModel(
    //           uid: e['uid'],
    //           itemname: e['itemname'],
    //           oem: e['oem'],
    //           quantity: e['quantity'],
    //           discipline: e['discipline'],
    //           equipment: e['equipment'],
    //           project: e['project'],
    //           store: e['store'],
    //           timestamp: e['timestamp']))
    //         .toList()
    // ));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Wishlist clicked!");
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Cart clicked!");
    print(event.addedProduct);
    // emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist Navigate clicked!");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart Navigate clicked!");
    emit(HomeNavigateToCartPageActionState());
  }
}
