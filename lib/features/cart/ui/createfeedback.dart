
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/features/home/bloc/home_bloc.dart';
import 'package:mediafirst/features/home/ui/product_tile_widget.dart';
import 'package:mediafirst/features/posts/bloc/posts_bloc.dart';
import 'package:mediafirst/models/home_product.dart';
import 'package:mediafirst/models/transactionModel.dart';

class CreateFeedback extends StatefulWidget {
  const CreateFeedback({Key? key, required this.postsBloc, required this.homeBloc}) : super(key: key);
  final PostsBloc postsBloc;
  final HomeBloc homeBloc;
  @override
  State<CreateFeedback> createState() => _CreateFeedbackState();
}

class _CreateFeedbackState extends State<CreateFeedback> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // TextField Controllers
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _oemController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _discController = TextEditingController();
  final TextEditingController equipController = TextEditingController();
  final TextEditingController projController = TextEditingController();
  final TextEditingController storeController = TextEditingController();

  final TextEditingController _fromLocController = TextEditingController();
  final TextEditingController _toLocController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      ProductDataModel newProduct = ProductDataModel(
          itemname: _itemController.text,
          oem: _oemController.text,
          quantity: int.parse(_qtyController.text),
          discipline: _discController.text,
          equipment: equipController.text,
          project: projController.text,
          store: storeController.text,
          uid: 0,
          timestamp: DateTime.now()
      );

      widget.postsBloc.add(PostsAddSubmitButtonClickedEvent(addProduct:newProduct));
    }
  }

  Future<void> _submitUpdateForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      ProductDataModel updateProduct = ProductDataModel(
          itemname: _itemController.text,
          oem: _oemController.text,
          quantity: int.parse(_qtyController.text),
          discipline: _discController.text,
          equipment: equipController.text,
          project: projController.text,
          store: storeController.text,
          uid: int.parse(_uidController.text),
          timestamp: DateTime.now()
      );

      widget.postsBloc.add(PostsUpdateSubmitButtonClickedEvent(updatedProduct:updateProduct));
    }
  }

  Future<void> _submitTransactionForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      ProductTransDataModel tProduct = ProductTransDataModel(
          itemname: _itemController.text,
          quantity: int.parse(_qtyController.text),
          uid: 0,
          timestamp: DateTime.now(),
          comments: _commentsController.text,
          fromLoc: _fromLocController.text,
          toLoc: _toLocController.text,
          itemUid: int.parse(_uidController.text),
      );

      widget.postsBloc.add(PostsTransactionSubmitButtonClickedEvent(transProductModel:tProduct));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      bloc: widget.postsBloc,
      listenWhen: (previous, current) => current is PostsActionState,
      buildWhen: (previous, current) => current is !PostsActionState,
      listener: (context, state) {
        if(state is PostsAdditionSuccessState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success!")));
          widget.postsBloc.add(PostsInitialFetchEvent());
          Navigator.of(context).pop();
        }else if(state is PostsTransactionAdditionSuccessState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success!")));
          widget.homeBloc.add(HomeInitialEvent());
          widget.postsBloc.add(PostsInitialFetchEvent());
          Navigator.of(context).pop();
        }else if(state is PostsAdditionErrorState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error!")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case PostsLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PostsAdditionState:
            return Center(
                child: Card(
                  elevation: 1.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child:
                          Padding(padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  // initialValue: widget.product.itemname,
                                  controller: _itemController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Item Name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Item Name'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.oem,
                                  controller: _oemController,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid OEM';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'OEM'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.quantity.toString(),
                                  controller: _qtyController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Quantity';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.discipline,
                                  controller: _discController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Discipline';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Discipline'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.equipment,
                                  controller: equipController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Equipment';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Equipment'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.project,
                                  controller: projController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Project';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Project',
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.store,
                                  controller: storeController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Store';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Store'
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            child: const Text('Submit'),
                          ),
                          const SizedBox(width: defaultPadding),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          case PostsUpdateFormState:
            final updateState = state as PostsUpdateFormState;
            _uidController.text = updateState.product.uid.toString();
            _itemController.text = updateState.product.itemname;
            _oemController.text = updateState.product.oem;
            _qtyController.text = updateState.product.quantity.toString();
            _discController.text = updateState.product.discipline;
            equipController.text = updateState.product.equipment;
            projController.text = updateState.product.project;
            storeController.text = updateState.product.store;
            return Center(
                child: Card(
                  elevation: 1.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child:
                          Padding(padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  // initialValue: updateState.product.itemname,
                                  controller: _itemController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Item Update Name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Item Name'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: updateState.product.oem,
                                  controller: _oemController,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid OEM';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'OEM'
                                  ),
                                ),
                                // TextFormField(
                                //   // initialValue: widget.product.quantity.toString(),
                                //   controller: _qtyController,
                                //   keyboardType: TextInputType.number,
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'Enter Valid Quantity';
                                //     }
                                //     return null;
                                //   },
                                //   decoration: const InputDecoration(
                                //     labelText: 'Quantity',
                                //   ),
                                // ),
                                TextFormField(
                                  // initialValue: widget.product.discipline,
                                  controller: _discController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Discipline';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Discipline'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.equipment,
                                  controller: equipController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Equipment';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Equipment'
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.project,
                                  controller: projController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Project';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Project',
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.store,
                                  controller: storeController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Store';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Store'
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitUpdateForm();
                            },
                            child: const Text('Update'),
                          ),
                          const SizedBox(width: defaultPadding),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          case PostsTransactionFormState:
            final updateState = state as PostsTransactionFormState;
            _uidController.text = updateState.product.uid.toString();
            _itemController.text = updateState.product.itemname;
            _oemController.text = updateState.product.oem;
            _qtyController.text = updateState.product.quantity.toString();
            _discController.text = updateState.product.discipline;
            equipController.text = updateState.product.equipment;
            projController.text = updateState.product.project;
            storeController.text = updateState.product.store;
            return Center(
                child: Card(
                  elevation: 1.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child:
                          Padding(padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _itemController.text,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                _oemController.text,
                                style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  _discController.text,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  equipController.text,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  projController.text,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  storeController.text,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                TextFormField(
                                // initialValue: widget.product.quantity.toString(),
                                  controller: _qtyController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                    return 'Enter Valid Quantity';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.project,
                                  controller: _fromLocController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid data';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'From Location',
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.project,
                                  controller: _toLocController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid data';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'To Location',
                                  ),
                                ),
                                TextFormField(
                                  // initialValue: widget.product.project,
                                  controller: _commentsController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Valid Comments';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Comments',
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitTransactionForm();
                            },
                            child: const Text('Create Transaction'),
                          ),
                          const SizedBox(width: defaultPadding),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          case PostsProductDataFormState:
            final updateState = state as PostsProductDataFormState;
            _uidController.text = updateState.product.uid.toString();
            _itemController.text = updateState.product.itemname;
            _oemController.text = updateState.product.oem;
            _qtyController.text = updateState.product.quantity.toString();
            _discController.text = updateState.product.discipline;
            equipController.text = updateState.product.equipment;
            projController.text = updateState.product.project;
            storeController.text = updateState.product.store;
            return Column(
              children: [
                Center(
                    child: Card(
                      elevation: 1.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Form(
                              key: _formKey,
                              child:
                              Padding(padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _itemController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      _oemController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      _qtyController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      _discController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      equipController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      projController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      storeController.text,
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // _submitUpdateForm();
                                },
                                child: const Text('Create Transaction'),
                              ),
                              const SizedBox(width: defaultPadding),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              Container(
                padding: const EdgeInsets.all(defaultPadding),
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
                      child: Text("Recent ${updateState.tproducts.length} transactions!")
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
                            updateState.tproducts.length,
                        (index) => recentFileDataRow(
                        homeBloc: widget.homeBloc,
                        productDataModel: updateState.tproducts[index])
                        ),
                        )
                      )
                    ]),
                  ),
                  ],
                ),
              )
              ],
            );
          default:
            return const Center(child: Text ('Error'));
        }
      },
    );
  }
}
