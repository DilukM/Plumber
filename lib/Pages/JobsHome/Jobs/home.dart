import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/profile.dart';
import 'package:plumber/global/globalValues.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'postJobRequest.dart';

import 'browseJobs.dart';
import 'findJobs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late FindJobs findJobs;
  late BrowseJobs search;
  late JobRequestPost post;
  late ChatPage chat;
  late Profile profile;
  late BrowseJobs browseJobs;

  @override
  void initState() {
    findJobs = const FindJobs();
    search = const BrowseJobs();
    post = const JobRequestPost();
    chat = const ChatPage();
    profile = const Profile();
    browseJobs = const BrowseJobs();
    pages = [findJobs, search, post, chat, profile];
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
                    Icon(
                      Icons.add_outlined,
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
            ],
          ),
        ]),
      ),
    );
  }
}
