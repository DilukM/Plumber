import 'package:plumber/Pages/JobsHome/Jobs/availableJobs.dart';
import 'package:plumber/Pages/JobsHome/PostJob/browseJobs.dart';
import 'package:plumber/Pages/JobsHome/PostJob/postJobsHome.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostJobs extends StatefulWidget {
  const PostJobs({super.key});

  @override
  State<PostJobs> createState() => _PostJobsState();
}

class _PostJobsState extends State<PostJobs> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late PostJobsHome findJobs;
  late AvailableJobs availableJobs;
  late BrowseJobRequests browseJobs;

  @override
  void initState() {
    findJobs = const PostJobsHome();
    browseJobs = const BrowseJobRequests();
    availableJobs = AvailableJobs();

    pages = [findJobs, browseJobs, availableJobs];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: pages[value.postIndex],
      ),
    );
  }
}
