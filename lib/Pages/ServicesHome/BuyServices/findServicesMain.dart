import 'package:plumber/Pages/ServicesHome/BuyServices/availableServices.dart';
import 'package:plumber/Pages/ServicesHome/BuyServices/browseServices.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'findServicesHome.dart';

class FindServicesMain extends StatefulWidget {
  const FindServicesMain({super.key});

  @override
  State<FindServicesMain> createState() => _FindServicesMainState();
}

class _FindServicesMainState extends State<FindServicesMain> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late FindServicesHome findJobs;
  late AvailableServices availableJobs;
  late BrowseServices browseJobs;

  @override
  void initState() {
    findJobs = const FindServicesHome();
    browseJobs = const BrowseServices();
    availableJobs = AvailableServices();

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
