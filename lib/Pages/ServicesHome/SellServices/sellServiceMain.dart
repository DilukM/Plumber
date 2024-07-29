// ignore_for_file: unused_import

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plumber/Pages/JobsHome/PostJob/postJobsHome.dart';
import 'package:plumber/Pages/ProductsHome/SellProduct/sellProductsHome.dart';
import 'package:plumber/Pages/ProductsHome/SellProduct/sellProductsPost.dart';
import 'package:plumber/Pages/ServicesHome/SellServices/sellServicePost.dart';
import 'package:plumber/Pages/ServicesHome/SellServices/sellServicesHome.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/search.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/globalValues.dart';
import '../../profile.dart';

class SellServicesMainPage extends StatefulWidget {
  const SellServicesMainPage({super.key});

  @override
  State<SellServicesMainPage> createState() => _SellServicesMainPageState();
}

class _SellServicesMainPageState extends State<SellServicesMainPage> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late SellServicesHome postJobHome;
  late Search search;
  late SellServicePost post;
  late ChatPage chat;
  late Profile profile;

  @override
  void initState() {
    postJobHome = SellServicesHome();
    search = const Search();
    post = const SellServicePost();
    chat = const ChatPage();
    profile = const Profile();

    pages = [post, postJobHome, chat, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            height: 65,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 208, 8, 68),
            animationDuration: const Duration(milliseconds: 500),
            onTap: (int index) {
              setState(() {
                currentTabIndex = index;
                final func = context.read<Global>();
                func.setFindJobsIndex(0);
                func.setPostIndex(0);
              });
            },
            items: const [
              Icon(
                Icons.add_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.list_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.chat_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
            ]),
        body: pages[currentTabIndex],
      ),
    );
  }
}
