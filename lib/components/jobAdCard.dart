import 'package:flutter/material.dart';

class JobAddCard extends StatelessWidget {
  final String position;
  final String company;
  final String location;
  final ImageProvider cover;
  void Function()? onTap;

  JobAddCard({
    Key? key,
    required this.position,
    required this.company,
    required this.location,
    required this.cover,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 4,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.cover, image: cover)),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      position,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Image.asset('assets/Rectangel star.png'),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
