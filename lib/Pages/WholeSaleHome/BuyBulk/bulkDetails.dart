import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/globalValues.dart';

class BulkDetails extends StatefulWidget {
  final String jobId;
  const BulkDetails({super.key, required this.jobId});

  @override
  State<BulkDetails> createState() => _BulkDetailsState();
}

class _BulkDetailsState extends State<BulkDetails> {
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
                  .collection('bulk')
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
                  return Center(child: Text('product not found'));
                }

                var jobData = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(jobData['coverUrl']),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
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
                                  child: Text("Brand:"),
                                ),
                                Text('${jobData['brand']}')
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Model:"),
                                ),
                                Text('${jobData['model']}')
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Price:"),
                                ),
                                Text('LKR ${jobData['price']}.00')
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Units per bulk:"),
                                ),
                                Text(jobData['units'])
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text("Location:"),
                                ),
                                Text(
                                    '${jobData['district']}, ${jobData['area']}')
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
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
                              "Description",
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
                                  child: Text("Chat"))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Call Seller"))),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
