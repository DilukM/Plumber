import 'package:plumber/components/welcomeCard.dart';
import 'package:flutter/material.dart';

class WholeSaleSelection extends StatefulWidget {
  const WholeSaleSelection({super.key});

  @override
  State<WholeSaleSelection> createState() => _WholeSaleSelectionState();
}

class _WholeSaleSelectionState extends State<WholeSaleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeCard(
                titleEN: 'BULK PURCHASE',
                onTap: '/buyBulk',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'තොග මිලදී ගැනීම',
                subtitle:
                    'ඔබට අවශ්‍ය නිෂ්පාදන තොග මිලට මිලදී ගැනීමට පිවිසෙන්න'),
            WelcomeCard(
                titleEN: 'WHOLESALE',
                onTap: '/sellBulk',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'තොග විකිණීම',
                subtitle: 'ඔබගේ නිෂ්පාදන තොග මිලට විකිණීමට පිවිසෙන්න'),
          ],
        ),
      ),
    );
  }
}
