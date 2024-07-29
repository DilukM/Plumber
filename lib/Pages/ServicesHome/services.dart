import 'package:plumber/components/welcomeCard.dart';
import 'package:flutter/material.dart';

class ServiceSelection extends StatefulWidget {
  const ServiceSelection({super.key});

  @override
  State<ServiceSelection> createState() => _ServiceSelectionState();
}

class _ServiceSelectionState extends State<ServiceSelection> {
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
                titleEN: 'BUY SERVICES',
                onTap: '/buyservicesMain',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'සේවා මිලදී ගැනීම',
                subtitle: 'ඔබට අවශ්‍ය සේවා මිලදී ගැනීමට පිවිසෙන්න'),
            WelcomeCard(
                titleEN: 'SELL SERVICES',
                onTap: '/sellservicesMain',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'සේවා විකිණීම',
                subtitle: 'ඔබට අවශ්‍ය සේවා විකිණීමට පිවිසෙන්න'),
          ],
        ),
      ),
    );
  }
}
