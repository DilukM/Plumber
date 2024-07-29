import 'package:flutter/material.dart';

class ListTileSettings extends StatelessWidget {
  final String title;
  final IconData icon; // New property for the background image

  const ListTileSettings({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white.withOpacity(0.3),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromARGB(255, 215, 26, 86).withOpacity(0.1),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Color.fromARGB(255, 215, 26, 86),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
