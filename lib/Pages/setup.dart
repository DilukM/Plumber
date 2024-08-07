import 'package:plumber/components/welcomeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/globalValues.dart';
import '../provider/auth_provider.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          iconTheme: IconThemeData(color: Colors.grey[900]),
          title: Text(
            'Hello ' + ap.userModel.firstname + ' ' + ap.userModel.lastname,
            style: TextStyle(color: Colors.grey[900]),
          ),
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
          padding: EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              WelcomeCard(
                  titleEN: 'Services',
                  onTap: '/postJobHome',
                  image: AssetImage('assets/find jobs.jpg'),
                  title: 'රැකියා',
                  subtitle: 'Request Your Service Need'),
              SizedBox(
                height: 20,
              ),
              WelcomeCard(
                  titleEN: 'PRODUCTS',
                  onTap: '/products',
                  image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
                  title: 'භාණ්ඩ',
                  subtitle: 'Buy and Sell Products'),
              SizedBox(
                height: 20,
              ),
              // WelcomeCard(
              //     titleEN: 'SERVICES',
              //     onTap: '/services',
              //     image: AssetImage('assets/Stuff-Best-Laptop-Lead.webp'),
              //     title: 'සේවා',
              //     subtitle: 'Find and Post Services'),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
