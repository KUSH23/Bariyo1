import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/features/home/bloc/home_bloc.dart';
import 'package:mediafirst/features/posts/bloc/posts_bloc.dart';
import 'package:mediafirst/models/home_product.dart';
import 'package:mediafirst/models/transactionModel.dart';

DataRow recentFileDataRow({required ProductTransDataModel productDataModel, required HomeBloc homeBloc}) {
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(productDataModel.timestamp);
  return DataRow(
    color: MaterialStateColor.resolveWith((states) {
      return productDataModel.quantity! < 0 ? Colors.red : secondaryColor; //make tha magic!
    }),
    cells: [
      DataCell(
        Row(
          children: [
            // SvgPicture.asset(
            //   "assets/icons/xd_file.svg",
            //   height: 30,
            //   width: 30,
            // ),
            CircleAvatar(
              backgroundColor: secondaryColor,
              child: Text(productDataModel.uid!.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productDataModel.itemname!
                  .substring(0,productDataModel.itemname!.length>25
                  ?25:productDataModel.itemname!.length)),
            ),
          ],
        ),
      ),
      DataCell(Text(formattedDate)),
      DataCell(Text(productDataModel.quantity!.toString()),),
      DataCell(IconButton(
        onPressed: (){
          // homeBloc.add(HomeProductCartButtonClickedEvent(addedProduct: productDataModel));
        },
        icon: const Icon(Icons.panorama_fish_eye_outlined),
      )),
    ],
  );
}

DataRow productFileDataRow({required ProductDataModel productDataModel, required PostsBloc postsBloc}) {
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(productDataModel.timestamp);
  return DataRow(
    color: MaterialStateColor.resolveWith((states) {
      return productDataModel.quantity! < 0 ? Colors.red : secondaryColor; //make tha magic!
    }),
    cells: [
      DataCell(
        Row(
          children: [
            // SvgPicture.asset(
            //   "assets/icons/xd_file.svg",
            //   height: 30,
            //   width: 30,
            // ),
            CircleAvatar(
              backgroundColor: secondaryColor,
              child: Text(productDataModel.uid!.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productDataModel.itemname!
                  .substring(0,productDataModel.itemname!.length>25
                  ?25:productDataModel.itemname!.length)),
            ),
          ],
        ),
      ),
      // DataCell(
      //   Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      //     child: Text(formattedDate),
      //   ),
      // ),
      // DataCell(Text(productDataModel.timestamp!.toString()),),
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(productDataModel.quantity!.toString()),
        ),
      ),
      DataCell(
          Row(
            children: [
              IconButton(
                onPressed: (){
                  postsBloc.add(PostsProductUpdateButtonClickedEvent(maProduct: productDataModel));
                },
                icon: const Icon(Icons.create),
              ),
              IconButton(
                onPressed: (){
                  postsBloc.add(PostsProductTransactionButtonClickedEvent(maProduct: productDataModel));
                },
                icon: const Icon(Icons.edit_attributes_outlined),
              ),
              IconButton(
                onPressed: (){
                  postsBloc.add(PostsProductUpdateButtonClickedEvent(maProduct: productDataModel));
                },
                icon: const Icon(Icons.track_changes_outlined),
              ),
            ],
          ),
      ),
    ],
  );
}

