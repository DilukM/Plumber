import 'package:plumber/global/globalValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FaQ extends StatefulWidget {
  String? title;
  FaQ({
    super.key,
    this.title,
  });

  final List<Map<String, String>> faqs = [
    {
      'question': 'How can I update my profile?',
      'answer':
          'Go to the profile section and click on "Edit Profile" to update your information.'
    },
    {
      'question': 'What should I do if I forget my password?',
      'answer':
          'Click on the "Forgot Password" link on the login page and follow the instructions.'
    },
    {
      'question': 'How do I apply for a job?',
      'answer':
          'To apply for a job, click on the job listing and then click the "Apply" button.'
    },
    {
      'question': 'How do I post a job?',
      'answer':
          'Click on the "Post Jobs" link on the Setup page after the Welocme page and follow the instructions.'
    },
    {
      'question': 'How do I buy a Product?',
      'answer':
          'Click on the "Products Jobs" link on the Setup page after the Welocme page and follow the instructions.'
    },
    {
      'question': 'How do I sell a Product?',
      'answer':
          'Click on the "Products Jobs" link on the Setup page after the Welocme page and follow the instructions.'
    },
  ];

  @override
  State<FaQ> createState() => _FaQState();
}

class _FaQState extends State<FaQ> {
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
                ? "FAQ"
                : '${widget.title}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: widget.faqs.map((faq) {
              return ExpansionTile(
                title: Text(
                  faq['question']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(faq['answer']!),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
