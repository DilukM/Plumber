import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String titleEN;
  final String subtitle;
  final String onTap;
  const WelcomeCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onTap,
      required this.titleEN});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, onTap);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12),
          height: 150,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 4), blurRadius: 5)
              ],
              color: const Color.fromARGB(255, 22, 1, 7),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: image, fit: BoxFit.cover, opacity: 0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                titleEN,
                style: TextStyle(
                    color: const Color.fromARGB(255, 255, 230, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                textAlign: TextAlign.center,
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              )
            ],
          ),
        ),
      ),
    );
  }
}
