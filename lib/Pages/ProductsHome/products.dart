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
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 0),
                  child: Text(
                    "Powered by",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/SRN Logo.png'),
            ),
          ],
        ),
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
                subtitle:
                    'Buy used or brandnew products for a reasonable price'),
            WelcomeCard(
                titleEN: 'SELL PRODUCTS',
                onTap: '/sellProduct',
                image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                title: 'භාණ්ඩ විකිණීම',
                subtitle: 'Sell your products for the best price'),
          ],
        ),
      ),
    );
  }
}
