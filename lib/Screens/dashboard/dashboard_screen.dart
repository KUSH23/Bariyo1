import 'package:mediafirst/constants.dart';
import 'package:mediafirst/features/home/bloc/home_bloc.dart';
import 'package:mediafirst/features/posts/bloc/posts_bloc.dart';
import 'package:mediafirst/features/posts/ui/post_page.dart';
import 'package:mediafirst/responsive.dart';
import 'package:mediafirst/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import 'components/header.dart';

import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeBloc homeBloc = HomeBloc();
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(postsBloc: postsBloc),
                      const SizedBox(height: defaultPadding),
                      // const RecentFiles(),
                      PostsPage(postsBloc: postsBloc),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(homeBloc: homeBloc),
                    ],
                )),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                   Expanded(
                    flex: 2,
                    child: StorageDetails(homeBloc: homeBloc),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}