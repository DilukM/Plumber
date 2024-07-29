import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final String title;
  final Image icon; // New property for the background image

  void Function()? onTap;

  SearchCard({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 231, 231, 231), Colors.white]),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(54, 0, 0, 0),
                offset: Offset(5, 5),
                blurRadius: 4,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                child: icon,
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  minFontSize: 7,
                  maxFontSize: 12,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
