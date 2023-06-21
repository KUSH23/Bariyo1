import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key, required this.wishlistBloc});
  final WishlistBloc wishlistBloc;
  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      bloc: widget.wishlistBloc,
      listenWhen: (previous, current) => current is WishlistNavigateState,
      buildWhen: (previous, current) => current is !WishlistNavigateState,
      listener: (context, state) {
        // if(state is PostsAdditionSuccessState){
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Added!")));
        //   widget.postsBloc.add(PostsInitialFetchEvent());
        //   Navigator.of(context).pop();
        // }else if(state is PostsAdditionErrorState){
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error!")));
        // }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case WishlistLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          // case WishlistInitial:
          //   final updateState = state as PostsTransactionFormState;
          //   _uidController.text = updateState.product.uid.toString();
          //   _itemController.text = updateState.product.itemname;
          //   _oemController.text = updateState.product.oem;
          //   _qtyController.text = updateState.product.quantity.toString();
          //   _discController.text = updateState.product.discipline;
          //   equipController.text = updateState.product.equipment;
          //   projController.text = updateState.product.project;
          //   storeController.text = updateState.product.store;
          //   return Center(
          //       child: Card(
          //         elevation: 1.0,
          //         margin: const EdgeInsets.all(8.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             Form(
          //                 key: _formKey,
          //                 child:
          //                 Padding(padding: const EdgeInsets.all(16),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: <Widget>[
          //                       Text(
          //                         _itemController.text,
          //                         style: const TextStyle(fontStyle: FontStyle.italic),
          //                       ),
          //                       Text(
          //                         _oemController.text,
          //                         style: const TextStyle(fontStyle: FontStyle.italic),
          //                       ),
          //                       TextFormField(
          //                         // initialValue: widget.product.quantity.toString(),
          //                         controller: _qtyController,
          //                         keyboardType: TextInputType.number,
          //                         validator: (value) {
          //                           if (value!.isEmpty) {
          //                             return 'Enter Valid Quantity';
          //                           }
          //                           return null;
          //                         },
          //                         decoration: const InputDecoration(
          //                           labelText: 'Quantity',
          //                         ),
          //                       ),
          //                       Text(
          //                         _discController.text,
          //                         style: const TextStyle(fontStyle: FontStyle.italic),
          //                       ),
          //                       Text(
          //                         equipController.text,
          //                         style: const TextStyle(fontStyle: FontStyle.italic),
          //                       ),
          //                       Text(
          //                         projController.text,
          //                         style: const TextStyle(fontStyle: FontStyle.italic),
          //                       ),
          //                       Text(
          //                         storeController.text,
          //                         style: const TextStyle(fontStyle: FontStyle.italic),
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 ElevatedButton(
          //                   onPressed: () {
          //                     // _submitUpdateForm();
          //                   },
          //                   child: const Text('Create Transaction'),
          //                 ),
          //                 const SizedBox(width: defaultPadding),
          //                 ElevatedButton(
          //                   onPressed: () {
          //                     Navigator.of(context).pop();
          //                   },
          //                   child: const Text('Cancel'),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       )
          //   );
          default:
            return const Center(child: Text ('Error'));
        }
      },
    );
  }
}
