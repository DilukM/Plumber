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
          height: 200,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 4), blurRadius: 5)
              ],
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 162, 0),
                Color.fromARGB(255, 255, 197, 8)
              ]),
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
                    color: Colors.grey[900],
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              // Text(
              //   textAlign: TextAlign.center,
              //   title,
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold),
              // ),
              Text(
                textAlign: TextAlign.center,
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
