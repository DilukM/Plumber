import 'package:plumber/Pages/JobsHome/Jobs/availableJobs.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'browseJobs.dart';
import 'findJobsHome.dart';

class FindJobs extends StatefulWidget {
  const FindJobs({super.key});

  @override
  State<FindJobs> createState() => _FindJobsState();
}

class _FindJobsState extends State<FindJobs> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late FindJobsHome findJobs;
  late AvailableJobs availableJobs;
  late BrowseJobs browseJobs;

  @override
  void initState() {
    findJobs = const FindJobsHome();
    browseJobs = const BrowseJobs();
    availableJobs = AvailableJobs();

    pages = [findJobs, browseJobs, availableJobs];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: pages[value.findJobsIndex],
      ),
    );
  }
}
