import 'package:plumber/components/welcomeCard.dart';
import 'package:flutter/material.dart';

class ProductSelection extends StatefulWidget {
  const ProductSelection({super.key});

  @override
  State<ProductSelection> createState() => _ProductSelectionState();
}

class _ProductSelectionState extends State<ProductSelection> {
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
                titleEN: 'BUY PRODUCTS',
                onTap: '/productsMain',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'භාණ්ඩ මිලදී ගැනීම',
                subtitle: 'ඔබට අවශ්‍ය භාණ්ඩ මිලදී ගැනීමට පිවිසෙන්න'),
            WelcomeCard(
                titleEN: 'SELL PRODUCTS',
                onTap: '/sellProduct',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'භාණ්ඩ විකිණීම',
                subtitle: 'ඔබට අවශ්‍ය භාණ්ඩ විකිණීමට පිවිසෙන්න'),
          ],
        ),
      ),
    );
  }
}
