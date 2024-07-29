import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/themes/theme.dart';
import 'OTP.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool hidePassword = true;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of verification code completed
        UserCredential result = await auth.signInWithCredential(credential);
        User? user = result.user;

        // If verification is successful, you can proceed with user registration
        // and navigation to the OTP verification page
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Verification code sent to the provided phone number
        // Navigate to OTP verification page and pass verificationId
        // and resendToken as parameters
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTP(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval of verification code timed out
        print("Verification code retrieval timed out");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 60.0, right: 16, left: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 60, child: Image.asset('assets/logo.png')),
              Text(
                'Welcome',
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
                  fontWeight: FontWeight.w900,
                  color: AppTheme.colors.primary,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              IntlPhoneField(
                controller: mobileController,
                disableLengthCheck: true,
                decoration: const InputDecoration(
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
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: hidePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: hidePassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: hidePassword,
                controller: cPasswordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: hidePassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  labelText: 'Confirm Password',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // verifyPhoneNumber(mobileController.text);
                    Navigator.pushNamed(context, '/setup');
                  },
                  child: const Text("Register"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "OR",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.transparent),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 20, child: Image.asset('assets/Google.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Register with Google"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 20,
                          child: const Icon(
                            Icons.facebook_outlined,
                            color: Colors.blue,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Register with Facebook"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 20, child: const Icon(Icons.email_outlined)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Register with Email"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0, top: 15),
                  child: Column(
                    children: [
                      AutoSizeText(
                        maxFontSize: 12,
                        minFontSize: 8,
                        "By Signing up for an account you agree to our",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Terms and Condition',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
