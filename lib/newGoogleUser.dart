import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/themes/theme.dart';
import 'models/userModel.dart';
import 'provider/auth_provider.dart';

class NewGoogleUser extends StatefulWidget {
  const NewGoogleUser({super.key});

  @override
  State<NewGoogleUser> createState() => _NewGoogleUserState();
}

class _NewGoogleUserState extends State<NewGoogleUser> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<CustomAuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.colors.primary,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Image.asset('assets/register.jpg')),
                      TextField(
                        controller: fnameController,
                        decoration: InputDecoration(
                          label: Text('First Name'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: lnameController,
                        decoration: InputDecoration(
                          label: Text('Last Name'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text('Email'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () => storeData(),
                          child: Text("Register"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void storeData() {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      phone: "",
      uid: "",
      createdAt: "",
      imageUrl: "",
      firstname: fnameController.text.trim(),
      lastname: lnameController.text.trim(),
      email: emailController.text.trim(),
    );
    ap.saveGoogleUserDataToFIrebase(
        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then((value) => ap.setSignIn().then((value) =>
              Navigator.pushNamedAndRemoveUntil(
                  context, '/setup', (route) => false)));
        });
  }
}
