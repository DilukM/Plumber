import 'package:flutter/material.dart';

import '../utils/themes/theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String label;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key, required this.title, required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black38,
              )
            ]),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppTheme.colors.primary),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppTheme.colors.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppTheme.colors.primary),
                ),
                label: Text(label),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
