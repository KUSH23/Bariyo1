import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/features/cart/ui/cart.dart';
import 'package:mediafirst/features/home/ui/product_tile_widget.dart';
import 'package:mediafirst/features/posts/bloc/posts_bloc.dart';
import 'package:mediafirst/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:mediafirst/screens/dashboard/components/header.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key, required this.postsBloc});
  final PostsBloc postsBloc;
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  WishlistBloc wishlistBloc = WishlistBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      bloc: widget.postsBloc,
      listenWhen: (previous, current) => current is PostsActionState,
      buildWhen: (previous, current) => current is !PostsActionState,
      listener: (context, state) {
        if(state is PostsAdditionState || state is PostsUpdateFormState || state is PostsTransactionFormState || state is PostsProductDataFormState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart(postsBloc: widget.postsBloc, wishlistBloc:wishlistBloc)));
        }
        // }else if(state is PostsAdditionErrorState){
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error!")));
        // }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case PostsLoadingState:
            return Column(
              children: [
                Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SearchField(postsBloc: widget.postsBloc),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          case PostsLoadedSuccessState:
            final successState = state as PostsLoadedSuccessState;
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Files",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SearchField(postsBloc: widget.postsBloc),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      //       postsBloc.add((PostsAddEvent()));
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 5,
                            // minWidth: 600,
                            columns: const [
                              DataColumn(
                                label: Text("File Name"),
                              ),
                              // DataColumn(
                              //   label: Text("Date"),
                              // ),
                              DataColumn(
                                label: Text("Quantity"),
                              ),
                              DataColumn(
                                label: Text("Action"),
                              ),
                            ],
                            rows: List.generate(
                                successState.products.length,
                                    (index) => productFileDataRow(
                                        wishlistBloc: wishlistBloc,
                                    postsBloc: widget.postsBloc,
                                    productDataModel: successState.products[index])
                            ),
                          ),
                        )
                    )
                  ),
                ],
              ),
            );
          case PostsErrorState:
            return const Center(child: Text ('Error') );
          default:
            return  const Center(child: Text ('Error'));
        }
      },
    );
  }
}
