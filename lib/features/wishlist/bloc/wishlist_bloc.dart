import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediafirst/models/home_product.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<WishlistProductButtonClickedEvent>(wishlistProductButtonClickedEvent);

  }

  FutureOr<void> wishlistProductButtonClickedEvent(
      WishlistProductButtonClickedEvent event, Emitter<WishlistState> emit) {
    emit(WishlistLoadingState());
  }
}
