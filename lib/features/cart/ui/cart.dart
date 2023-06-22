import 'package:flutter/material.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/features/home/bloc/home_bloc.dart';
import 'package:mediafirst/features/posts/bloc/posts_bloc.dart';
import 'package:mediafirst/features/cart/ui/createfeedback.dart';
import 'package:mediafirst/features/wishlist/bloc/wishlist_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.postsBloc, required this.homeBloc});
  final PostsBloc postsBloc;
  final HomeBloc homeBloc;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Card(
          elevation: 1.0,
          margin: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CreateFeedback(postsBloc: widget.postsBloc, homeBloc: widget.homeBloc),
              ],
            ),
          )
        ),
      ),
    );
  }
}
