import 'package:plumber/components/welcomeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/globalValues.dart';
import '../provider/auth_provider.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Hello ' + ap.userModel.firstname + ' ' + ap.userModel.lastname,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 25,
                ),
                WelcomeCard(
                    titleEN: 'JOBS',
                    onTap: '/jobs',
                    image: AssetImage('assets/find jobs.jpg'),
                    title: 'රැකියා',
                    subtitle:
                        'ඔබගේ සුදුසුකම්වලට වඩාත් සරිලන රැකියාවක් සොයා ගැනීමට සහ ඔබගේ සේවා ස්ථානය සඳහා සේවකයින් සොයා ගැනීමට පිවිසෙන්න'),
                WelcomeCard(
                    titleEN: 'PRODUCTS',
                    onTap: '/products',
                    image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                    title: 'භාණ්ඩ',
                    subtitle:
                        'ඔබට අවශ්‍ය භාණ්ඩ මිලදී ගැනීමට සහ විකිණීමට පිවිසෙන්න'),
                WelcomeCard(
                    titleEN: 'SERVICES',
                    onTap: '/services',
                    image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                    title: 'සේවා',
                    subtitle:
                        'ඔබට අවශ්‍ය සේවා මිලදී ගැනීමට සහ විකිණීමට පිවිසෙන්න'),
                WelcomeCard(
                    titleEN: 'WHOLESALE MARKET',
                    onTap: '/wholesale',
                    image: AssetImage('assets/stock.jpg'),
                    title: 'තොග වෙළඳපොල',
                    subtitle:
                        'ඔබට අවශ්‍ය නිෂ්පාදන තොග මිලට විකිණීමට සහ මිලදී ගැනීමට පිවිසෙන්න'),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
