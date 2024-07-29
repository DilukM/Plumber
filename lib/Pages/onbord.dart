import 'package:flutter/material.dart';

import '../utils/themes/theme.dart';

class Onbord extends StatelessWidget {
  const Onbord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  Text(
                    'Find your Dream Job',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.colors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.asset('assets/logo.png')),
                  SizedBox(
                    height: 120,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/setup');
                          },
                          child: Text("Register"))),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/setup');
                          },
                          child: Text("Login"))),
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Powered by Silicon System",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )),
        ],
      ),
    );
  }
}
