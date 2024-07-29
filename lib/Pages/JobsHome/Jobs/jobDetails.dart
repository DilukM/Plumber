import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobDetails extends StatefulWidget {
  final String jobId;
  const JobDetails({super.key, required this.jobId});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Details",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('jobpositions')
                  .doc(widget.jobId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('Job not found'));
                }

                var jobData = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                jobData['title'] + ' | ' + jobData['district'],
                                style: TextStyle(
                                    color: AppTheme.colors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black38,
                          )
                        ]),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child:
                                            Image.network(jobData['coverUrl']),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            jobData['title'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            jobData['district'],
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            jobData['company'],
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Image.asset(
                                              'assets/Rectangel star.png'),
                                          Text(
                                            'Member since January 2024',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Job location:"),
                                ),
                                Text(jobData['district'])
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Employer:"),
                                ),
                                Text(jobData['company'])
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Job Type:"),
                                ),
                                Text("Part time / Full time")
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Salary per Month:"),
                                ),
                                Text("Rs. 45,000 - 80,000")
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Required (work Experience):"),
                                ),
                                Text(jobData['experience'])
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Employer website:"),
                                ),
                                Text("www.hempvt.lk")
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black38,
                          )
                        ]),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Requirements",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              jobData['requirements'],
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "About the role",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              jobData['description'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    final currentUser =
                                        FirebaseAuth.instance.currentUser;

                                    if (currentUser != null) {
                                      final currentUserId = currentUser.uid;
                                      final jobCreatorId = jobData[
                                          'uid']; // Ensure this field exists in your job document

                                      try {
                                        // Create a chat document inside the current user's account
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(currentUserId)
                                            .collection('chats')
                                            .doc(jobCreatorId)
                                            .set({
                                          'jobId': widget.jobId,
                                          'jobTitle': jobData['title'],
                                          'role': 'applicant',
                                          'jobCreatorId': jobCreatorId,
                                          'createdAt':
                                              FieldValue.serverTimestamp(),
                                        });

                                        // Create a chat document inside the job creator's account
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(jobCreatorId)
                                            .collection('chats')
                                            .doc(currentUserId)
                                            .set({
                                          'jobId': widget.jobId,
                                          'role': 'creator',
                                          'jobTitle': jobData['title'],
                                          'applicantId': currentUserId,
                                          'createdAt':
                                              FieldValue.serverTimestamp(),
                                        });
                                      } catch (e) {
                                        // Handle errors here
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Failed to apply: $e')),
                                        );
                                      }
                                    } else {
                                      // Handle the case when no user is logged in
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Please log in to apply')),
                                      );
                                    }
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage()));
                                  },
                                  child: Text("Apply Now"))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Call Employer"))),
                        ],
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
