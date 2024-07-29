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
class TermsCondition extends StatefulWidget {
  String? title;
  String? location;
  TermsCondition({super.key, this.title, this.location});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
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
                ? "Terms & Conditions"
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
                  'Terms & Conditions',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'These Terms and Conditions govern the use of and access to the mobile application Swadheena Mahajana Sabhawa. The Platform is owned and operated by Swadheena Mahajana Sabhawa, with its registered office at 177, Kandy, Sri Lanka and its affiliates. These Terms include our privacy policy, and any guidelines, additional terms, policies, or disclaimers made available by or issued by Swadheena Mahajana Sabhawa from time to time. We reserve the right to offer our users with free trials. These Terms would continue to apply to use of such free trials.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'These Terms would continue to apply to use of such free trials. These Terms constitute a binding and enforceable contract between Swadheena Mahajana Sabhawa and you, an end user of the Platform and the services available through the Platform. You may authorise other persons to use the Platform on your behalf in certain cases; in such events, you shall be liable for all acts or omissions of the person you authorise to use the Platform. If you are using the Platform on behalf of another party, you represent and warrant that (a) these Terms have been explained in their entirety to you and (b) you have the authority to enter into these Terms on behalf of such party and bind such party to these Terms. You represent and warrant that you have full legal capacity and authority to agree and bind yourself to these Terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'You represent that you are over 18 years of age. If you are below the age of 18, you may only use the Platform if your guardian or parent has expressly agreed to these Terms on your behalf, and your guardian or parent shall be responsible and liable for your obligations arising out of these Terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'By using the Platform, you agree that you have read, understood, and are bound by these Terms as amended from time to time, and that you comply with the requirements listed herein. If you do not agree to all of these Terms or comply with the requirements herein, please do not access or use the Platform.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Text(
              //   'PLATFORM',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //   ),
              // ),
              // SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
