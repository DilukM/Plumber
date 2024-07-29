import 'package:plumber/Pages/ProductsHome/BuyProducts/availableProducts.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'browseProducts.dart';
import 'findProductsHome.dart';

class FindProducts extends StatefulWidget {
  const FindProducts({super.key});

  @override
  State<FindProducts> createState() => _FindProductsState();
}

class _FindProductsState extends State<FindProducts> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late FindProductsHome findJobs;
  late AvailableProducts availableJobs;
  late BrowseProducts browseJobs;

  @override
  void initState() {
    findJobs = const FindProductsHome();
    browseJobs = const BrowseProducts();
    availableJobs = AvailableProducts();

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
