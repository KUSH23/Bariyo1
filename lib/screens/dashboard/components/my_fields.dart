
import 'package:mediafirst/features/posts/bloc/posts_bloc.dart';
import 'package:mediafirst/models/MyFiles.dart';
import 'package:mediafirst/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key, required  this.postsBloc,}) : super(key: key);
  final PostsBloc postsBloc;
  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  @override
  Widget build(BuildContext context) {
    // final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Spares List",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                widget.postsBloc.add(PostsAddButtonClickedEvent());
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        // Card(
        //   elevation: 1.0,
        //   margin: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: const BoxDecoration(color: Colors.blue),
        //     child:  InkWell(
        //       onTap: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const CreateFeedback(),
        //             ));
        //       },
        //       child: const Center(child: Text('Create'),),
        //     ),
        // ),),
        // Card(
        //   elevation: 1.0,
        //   margin: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: const BoxDecoration(color: Colors.blue),
        //     child:  InkWell(
        //       onTap: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const FeedbackSearchPage(),
        //             ));
        //       },
        //       child: const Center(child: Text('Inventory'),),
        //     ),
        // ),),
        const SizedBox(height: defaultPadding),
        // Responsive(
        //   mobile: FileInfoCardGridView(
        //     crossAxisCount: _size.width < 650 ? 2 : 4,
        //     childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
        //   ),
        //   tablet: const FileInfoCardGridView(),
        //   desktop: FileInfoCardGridView(
        //     childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
        //   ),
        // ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}