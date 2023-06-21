import 'package:flutter/material.dart';
import 'package:mediafirst/features/home/bloc/home_bloc.dart';
import 'package:mediafirst/features/home/ui/home.dart';

import '../../../constants.dart';


class StorageDetails extends StatefulWidget {
  const StorageDetails({Key? key, required this.homeBloc,})
      : super(key: key);
  final HomeBloc homeBloc;

  @override
  State<StorageDetails> createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Recent Transactions",
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          const SizedBox(height: defaultPadding),
          // Chart(),
          Home(homeBloc: widget.homeBloc),
        ],
      ),
    );
  }
}