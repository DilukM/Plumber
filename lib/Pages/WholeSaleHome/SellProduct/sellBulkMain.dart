// ignore_for_file: unused_import

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plumber/Pages/JobsHome/PostJob/postJobsHome.dart';
import 'package:plumber/Pages/ProductsHome/SellProduct/sellProductsHome.dart';
import 'package:plumber/Pages/ProductsHome/SellProduct/sellProductsPost.dart';
import 'package:plumber/Pages/WholeSaleHome/SellProduct/sellBulksHome.dart';
import 'package:plumber/Pages/WholeSaleHome/SellProduct/sellBulksPost.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/search.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/globalValues.dart';
import '../../profile.dart';

class SellBulksMainPage extends StatefulWidget {
  const SellBulksMainPage({super.key});

  @override
  State<SellBulksMainPage> createState() => _SellBulksMainPageState();
}

class _SellBulksMainPageState extends State<SellBulksMainPage> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late SellBulksHome postJobHome;
  late Search search;
  late SellBulkPost post;
  late ChatPage chat;
  late Profile profile;

  @override
  void initState() {
    postJobHome = SellBulksHome();
    search = const Search();
    post = const SellBulkPost();
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
