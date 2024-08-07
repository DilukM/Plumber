import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/profileEdit.dart';
import 'package:plumber/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

import '../components/listTileSettings.dart';
import '../provider/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUserData = FirebaseAuth.instance.currentUser;
  UserModel? _userModel;

  Map<String, dynamic> currentUser = {
    'name': '',
    'email': '',
    'imageUrl':
        'https://b3307141.smushcdn.com/3307141/wp-content/uploads/2022/08/WF1583936_5K3A9534.jpg?lossy=2&strip=1&webp=1',
  };

  Future<void> fetchUserData() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? "";
    setState(() {
      _userModel = UserModel.fromMap(jsonDecode(data));
      currentUser['name'] = _userModel!.firstname != ""
          ? _userModel!.firstname + ' ' + _userModel!.lastname
          : 'No Name';
      currentUser['email'] =
          _userModel!.email != "" ? _userModel!.email : 'No Email';
      currentUser['imageUrl'] = _userModel!.imageUrl != ""
          ? _userModel!.imageUrl
          : 'https://firebasestorage.googleapis.com/v0/b/odoc-e1695.appspot.com/o/uploads%2F30-307416_profile-icon-png-image-free-download-searchpng-employee.png?alt=media&token=e1e3474e-d3f9-4989-88c5-d5f551518fa5';
    });
  }

  Future<void> syncUserModelWithFirebase() async {
    final currentUserData = FirebaseAuth.instance.currentUser;
    if (currentUserData != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserData.uid)
          .get();
      if (userSnapshot.exists) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_model", jsonEncode(userSnapshot.data()));
      }
    }
  }

  Future<void> updateProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final fileName = path.basename(file.path);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(currentUserData!.uid)
        .child(fileName);

    await storageRef.putFile(file);
    final downloadUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserData!.uid)
        .update({'imageUrl': downloadUrl});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userModelStr = prefs.getString("user_model");
    if (userModelStr != null) {
      Map<String, dynamic> userModel = jsonDecode(userModelStr);
      userModel['imageUrl'] = downloadUrl;
      await prefs.setString("user_model", jsonEncode(userModel));
    }

    setState(() {
      currentUser['imageUrl'] = downloadUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.grey[900]),
        ),
      ),
      body: FutureBuilder<void>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      updateProfileImage();
                    },
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          currentUser['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentUser['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(currentUser['email']),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEdit()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.colors.primary,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  // SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/myads');
                    },
                    child: ListTileSettings(
                      title: "My Ads",
                      icon: Icons.ads_click,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/faq');
                    },
                    child: ListTileSettings(
                      title: "FAQ",
                      icon: Icons.question_answer,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/terms');
                    },
                    child: ListTileSettings(
                      title: "Terms and Conditions",
                      icon: Icons.rule,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/privacy');
                    },
                    child: ListTileSettings(
                      title: "Privacy Policy",
                      icon: Icons.privacy_tip,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        ap.clearUserDataFromSP().then((value) => ap
                            .setSignOut()
                            .then((value) => Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false)));
                      },
                      child: ListTileSettings(
                          title: "Log out", icon: Icons.logout)),
                  // SizedBox(
                  //   height: 100,
                  // )
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Version: 10.8.4',
                    style: TextStyle(color: Colors.grey),
                  ),
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
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
