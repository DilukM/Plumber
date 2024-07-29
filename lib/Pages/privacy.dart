import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/Jobs/jobDetails.dart';
import 'package:plumber/components/jobAdCard.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PrivacyPolicy extends StatefulWidget {
  String? title;
  String? location;
  PrivacyPolicy({super.key, this.title, this.location});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              final func = context.read<Global>();
              func.setFindJobsIndex(0);
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            (widget.title == null || widget.title == '')
                ? "Privacy Policy"
                : '${widget.title}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Introduction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This Privacy Policy outlines Swadheena Mahajana Sabhawa practice in relation to the storage, use, processing, and disclosure of personal data that you have chosen to share with us when you access our mobile application “Swadheena Mahajana Sabhawa” and when you interact with customer service and promotional activities conducted by us.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'At Swadheena Mahajana Sabhawa, we are committed to protecting your personal data and respecting your privacy. Please read this Policy carefully to understand our practices regarding your personal data and how we will treat it. The Policy sets out the basis on which any personal data we collect from you, or that you provide to us, will be processed by us.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Information Collection',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We collect information that you provide to us directly, such as when you create an account, or update your profile.This Policy together with our Terms applies to your use of the Platform through your phone, computer, or other device and of the services accessible through the Platform.',
                style: TextStyle(fontSize: 16),
              ),
              // Add more sections of your privacy policy here
              SizedBox(height: 20),
              Text(
                'Use of Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We use the information we collect to provide, maintain, and improve our services, as well as to communicate with you. By using the Platform, you consent to the collection, storage, use, and disclosure of your personal data, in accordance with, and are agreeing to be bound by this Policy. We will not collect any information from you, except where it is knowingly and explicitly provided by you.',
                style: TextStyle(fontSize: 16),
              ),
              // Add more sections as necessary
            ],
          ),
        ),
      ),
    );
  }
}
