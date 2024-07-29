import 'package:flutter/material.dart';
import 'package:flutter/src/material/text_theme.dart';
import 'package:provider/provider.dart';

import '../components/custom_clipper.dart';
import '../provider/auth_provider.dart';
import '../utils/themes/theme.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: CustomClipperWidget(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/welcomecover.jpg'))),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset('assets/logo.png')),
                      Text(
                        'iajdëk uyck iNdj',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Apex',
                          color: AppTheme.colors.primary,
                        ),
                      ),
                      Text(
                        'Swadhina Mahajana Sabhawa',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.transparent)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/amith');
                        },
                        child: Text(
                          "Amith Weerasinghe Profile",
                          style: TextStyle(color: AppTheme.colors.primary),
                        ))),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                        onPressed: () async {
                          ap.isSignedIn == true
                              ? await ap.getDataFromSP().whenComplete(
                                  () => Navigator.pushNamed(context, '/setup'))
                              : Navigator.pushNamed(context, '/login');
                        },
                        child: Text("Get Started"))),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Powered by Silicon Systems",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
