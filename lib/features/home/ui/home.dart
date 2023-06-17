import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/data/cart_data.dart';
import 'package:mediafirst/features/cart/ui/cart.dart';
import 'package:mediafirst/features/home/bloc/home_bloc.dart';
import 'package:mediafirst/features/home/ui/product_tile_widget.dart';
import 'package:mediafirst/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.homeBloc});
  final HomeBloc homeBloc;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: widget.homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        // if(state is HomeNavigateToCartPageActionState){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const Cart()));
        // } else if(state is HomeNavigateToWishlistPageActionState){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const Wishlist()));
        // } else if(state is HomeProductItemCartedActionState){
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added! $counter}")));
        // }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Recent Files",
                  //   style: Theme.of(context).textTheme.titleMedium,
                  // ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("Recent ${successState.products.length} transactions!")
                          ),
                          const SizedBox(height: 5,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 5,
                              // minWidth: 600,
                              columns: const [
                              DataColumn(
                              label: Text("File Name"),
                              ),
                              DataColumn(
                              label: Text("Date"),
                              ),
                              DataColumn(
                              label: Text("Quantity"),
                              ),
                              DataColumn(
                              label: Text("Action"),
                              ),
                            ],
                            rows: List.generate(
                            successState.products.length,
                            (index) => recentFileDataRow(
                            homeBloc: widget.homeBloc,
                            productDataModel: successState.products[index])
                            ),
                            )
                          )
                        ]),
                  ),
                ],
              ),
            );
          case HomeErrorState:
            return const Center(child: Text ('Error'));
          default:
            return const Center(child: Text ('home'));
        }
      },
    );
  }
}
