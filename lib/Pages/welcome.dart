import 'package:flutter/material.dart';
import 'package:plumber/test/jobrequest.dart';
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
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/bg.jpg'))),
          ),
          Column(
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
                                      image: AssetImage(
                                          'assets/0N0A8153-683x1024.webp'))),
                            ),
                          ),

                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Image.asset('assets/logo1.png')),
                          // Text(
                          //   'QUICK DEALS',
                          //   style: TextStyle(
                          //     fontSize: 32.0,
                          //     fontWeight: FontWeight.w900,
                          //     color: Colors.grey[900],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                            onPressed: () async {
                              ap.isSignedIn == true
                                  ? await ap.getDataFromSP().whenComplete(() =>
                                      Navigator.pushNamed(context, '/setup'))
                                  : Navigator.pushNamed(context, '/login');
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (contex) => BulkUploadPage()));
                            },
                            child: Text("Get Started",
                                style: TextStyle(color: Colors.grey[900])))),
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
            ],
          ),
        ],
      ),
    );
  }
}
