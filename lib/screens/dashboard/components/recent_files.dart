import 'package:mediafirst/controller/form_controller.dart';

import 'package:flutter/material.dart';
import 'package:mediafirst/models/transactionModel.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({Key? key,}) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {

  List<TransactionModel> filteredFeedbackItems = [];

  @override
  void initState() {
    super.initState();

    FormController().getTransactionList(null).then((feedbackItems) {
      setState(() {
        filteredFeedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: filteredFeedbackItems.isNotEmpty
                        ?Text("Recent ${filteredFeedbackItems.length} transactions!")
                        : const CircularProgressIndicator(),
                  ),
                  const SizedBox(height: 5,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: defaultPadding,
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
                        ],
                        rows: List.generate(
                          filteredFeedbackItems.length,
                              (index) => recentFileDataRow(filteredFeedbackItems[index]),
                        ),
                      )
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(TransactionModel fileInfo) {
  return DataRow(
    color: MaterialStateColor.resolveWith((states) {
      return int.parse(fileInfo.quantity!) < 0 ? Colors.red : secondaryColor; //make tha magic!
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
              child: Text(fileInfo.uid!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.itemname!
                  .substring(0,fileInfo.itemname!.length>25
                  ?25:fileInfo.itemname!.length)),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.timestamp!.substring(0,10)),),
      DataCell(Text(fileInfo.quantity!),),
    ],
  );
}