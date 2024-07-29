import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../utils/themes/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  String countryCode = '+94';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 16, left: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Image.asset('assets/login.jpg')),
              SizedBox(
                height: 30,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.colors.primary,
                ),
              ),
              Text(
                'Continue with Mobile Number & OTP',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              IntlPhoneField(
                controller: mobileController,
                onCountryChanged: (Country) {
                  countryCode = Country.code;
                },
                disableLengthCheck: true,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'LK',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    sendPhoneNumber();
                  },
                  child: Text("Continue"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "OR",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.transparent),
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 20, child: Image.asset('assets/Google.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Login with Google"),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Container(
              //             height: 20,
              //             child: Icon(
              //               Icons.facebook_outlined,
              //               color: Colors.blue,
              //             )),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text("Login with Facebook"),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Container(height: 20, child: Icon(Icons.email_outlined)),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text("Login with Email"),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void sendPhoneNumber() {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    String phoneNumber = mobileController.text.trim();
    ap.signInWithPhone(context, countryCode + phoneNumber);
  }

  void signInWithGoogle() {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    ap.signInWithGoogle(context);
  }
}
