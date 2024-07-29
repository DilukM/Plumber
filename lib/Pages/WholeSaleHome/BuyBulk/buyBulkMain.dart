import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/profile.dart';
import 'package:plumber/global/globalValues.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'postBulkRequest.dart';

import 'browseBulks.dart';
import 'findBulks.dart';

class BulkMainPage extends StatefulWidget {
  const BulkMainPage({super.key});

  @override
  State<BulkMainPage> createState() => _BulkMainPageState();
}

class _BulkMainPageState extends State<BulkMainPage> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late FindBulks findBulks;
  late BrowseBulks search;
  late BulkRequestPost post;
  late ChatPage chat;
  late Profile profile;
  late BrowseBulks browseJobs;

  @override
  void initState() {
    findBulks = const FindBulks();
    search = const BrowseBulks();
    post = const BulkRequestPost();
    chat = const ChatPage();
    profile = const Profile();
    browseJobs = const BrowseBulks();
    pages = [findBulks, search, chat, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: Stack(children: [
          pages[currentTabIndex],
          Column(
            children: [
              Expanded(child: SizedBox()),
              CurvedNavigationBar(
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
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    // Icon(
                    //   Icons.add_outlined,
                    //   color: Colors.white,
                    // ),
                    Icon(
                      Icons.chat_outlined,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.account_circle_rounded,
                      color: Colors.white,
                    ),
                  ]),
            ],
          ),
        ]),
      ),
    );
  }
}
