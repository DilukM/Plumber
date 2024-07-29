import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plumber/Pages/JobsHome/PostJob/browseJobs.dart';
import 'package:plumber/Pages/JobsHome/PostJob/findJobs.dart';
import 'package:plumber/Pages/JobsHome/PostJob/postJobPosition.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/profile.dart';
import 'package:plumber/global/globalValues.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobPostMainPage extends StatefulWidget {
  const JobPostMainPage({super.key});

  @override
  State<JobPostMainPage> createState() => _JobPostMainPageState();
}

class _JobPostMainPageState extends State<JobPostMainPage> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late PostJobs postJobHome;
  late BrowseJobRequests search;
  late JobPositionPost post;
  late ChatPage chat;
  late Profile profile;

  @override
  void initState() {
    postJobHome = const PostJobs();
    search = const BrowseJobRequests();
    post = const JobPositionPost();
    chat = const ChatPage();
    profile = const Profile();

    pages = [postJobHome, search, post, chat, profile];
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
        body: pages[currentTabIndex],
      ),
    );
  }
}
