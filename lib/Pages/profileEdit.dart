import 'dart:convert';

import 'package:plumber/components/underlineTextField.dart';
import 'package:plumber/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  UserModel? _userModel;
  bool _isLoading = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? _selectedBirthday;

  Future<void> fetchUserData() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? "";
    setState(() {
      _userModel = UserModel.fromMap(jsonDecode(data));
      _nameController.text = '${_userModel!.firstname} ${_userModel!.lastname}';
      _emailController.text = _userModel!.email;
      _phoneController.text = _userModel!.phone;

      _isLoading = false;
    });
  }

  Future<void> updateUserData() async {
    if (_formKey.currentState!.validate()) {
      if (_userModel != null) {
        List<String> nameParts = _nameController.text.split(' ');
        _userModel!.firstname = nameParts.first;
        _userModel!.lastname = nameParts.length > 1 ? nameParts.last : '';
        _userModel!.email = _emailController.text;
        _userModel!.phone = _phoneController.text;

        // Save to Shared Preferences
        SharedPreferences s = await SharedPreferences.getInstance();
        await s.setString("user_model", jsonEncode(_userModel!.toMap()));

        // Save to Firestore
        await _userModel!.uploadUserData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Updated successfully')),
        );

        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedBirthday)
      setState(() {
        _selectedBirthday = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal details',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: _nameController,
                        labelText: 'Name',
                        prefixIcon: Icons.person,
                        onChanged: (value) {
                          // Optionally handle changes here
                        },
                      ),
                      Text(
                        'Contact Information',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        onChanged: (value) {
                          // Optionally handle changes here
                        },
                      ),
                      CustomTextField(
                        controller: _phoneController,
                        labelText: 'Phone',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: validatePhoneNumber,
                        onChanged: (value) {
                          // Optionally handle changes here
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              updateUserData();
                            },
                            child: Text('Update')),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
