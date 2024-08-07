import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/PostJob/availableJobRequests.dart';
import 'package:plumber/Pages/JobsHome/PostJob/editPost.dart';
import 'package:plumber/Pages/JobsHome/PostJob/jobDetailsPost.dart';
import 'package:plumber/Pages/JobsHome/PostJob/postJobPosition.dart';
import 'package:plumber/components/JobRequestCard.dart';
import 'package:plumber/components/jobAdCard.dart';
import 'package:plumber/components/jobCategoryCard.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/provider/auth_provider.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PostJobsHome extends StatefulWidget {
  const PostJobsHome({super.key});

  @override
  State<PostJobsHome> createState() => _PostJobsHomeState();
}

class _PostJobsHomeState extends State<PostJobsHome> {
  final TextEditingController jobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

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
        iconTheme: IconThemeData(color: Colors.grey[900]),
        title: Text(
          "Ongoing Requests",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 60.0, right: 12, left: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('serviceNeeds')
                        .where('uid', isEqualTo: ap.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Placeholder while loading
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs.toList();
                        return Column(
                          children: documents.map((doc) {
                            return JobRequestCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPost(
                                      postID: doc.id, // Pass the document ID
                                    ),
                                  ),
                                );
                              },
                              title: doc['title'],
                              category: doc['category'],
                              address: doc['address'],
                              status: doc[
                                  'status'], // Assuming 'coverImageUrl' holds the URL of the cover image
                            );
                          }).toList(),
                        );
                      }
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Text('No Requests found.'),
                            SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JobPositionPost()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text('Create a Request'),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
