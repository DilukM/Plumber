import 'package:plumber/Pages/WholeSaleHome/BuyBulk/availableBulk.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'browseBulks.dart';
import 'findBulksHome.dart';

class FindBulks extends StatefulWidget {
  const FindBulks({super.key});

  @override
  State<FindBulks> createState() => _FindBulksState();
}

class _FindBulksState extends State<FindBulks> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late FindBulksHome findJobs;
  late AvailableBulks availableJobs;
  late BrowseBulks browseJobs;

  @override
  void initState() {
    findJobs = const FindBulksHome();
    browseJobs = const BrowseBulks();
    availableJobs = AvailableBulks();

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
