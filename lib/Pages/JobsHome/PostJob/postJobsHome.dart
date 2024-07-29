import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/PostJob/availableJobRequests.dart';
import 'package:plumber/Pages/JobsHome/PostJob/jobDetailsPost.dart';
import 'package:plumber/components/jobAdCard.dart';
import 'package:plumber/components/jobCategoryCard.dart';
import 'package:plumber/global/globalValues.dart';
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

  List<DropDownValueModel> dropDownList = [
    DropDownValueModel(name: 'Western Province', value: "value1"),
    DropDownValueModel(name: 'Central Province', value: "value2"),
    DropDownValueModel(name: 'Northern Province', value: "value3"),
    DropDownValueModel(name: 'North Central Province', value: "value4"),
    DropDownValueModel(name: 'Eastern Province', value: "value5"),
    DropDownValueModel(name: 'North Western Province', value: "value6"),
    DropDownValueModel(name: 'Sabaragamuwa', value: "value7"),
    DropDownValueModel(name: 'Southern Province', value: "value8"),
    DropDownValueModel(name: 'Uva', value: "value9"),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60.0, right: 12, left: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jobController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Find Job Requests',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // DropDownTextField(
                //   // controller: _findController,
                //   clearOption: true,
                //   enableSearch: true,
                //   textFieldDecoration: InputDecoration(
                //     prefixIcon: Icon(
                //       FontAwesomeIcons.locationDot,
                //     ),
                //   ),

                //   searchDecoration:
                //       const InputDecoration(icon: Icon(Icons.search)),
                //   validator: (value) {
                //     if (value == null) {
                //       return "Required field";
                //     } else {
                //       return null;
                //     }
                //   },
                //   dropDownItemCount: 6,

                //   dropDownList: dropDownList,
                //   onChanged: (val) {},
                // ),
                // SizedBox(
                //   height: 12,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/postJobsHome');
                    },
                    child: Text("Search"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    thickness: 3,
                    color: AppTheme.colors.primary,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black38,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Browse Job Requests",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Data Entry Operator",
                                              )));
                                },
                                title: "Data Entry Operator",
                                icon: Image.asset('assets/data-entry.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Sales Executive",
                                              )));
                                },
                                title: "Sales Executive",
                                icon: Image.asset('assets/sales.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Sales man",
                                              )));
                                },
                                title: "Sales man",
                                icon: Image.asset('assets/estate-agent.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Lawyer",
                                              )));
                                },
                                title: "Lawyer",
                                icon: Image.asset('assets/check-in.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "HR Manager",
                                              )));
                                },
                                title: "HR Manager",
                                icon: Image.asset('assets/recruitment.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Accountant",
                                              )));
                                },
                                title: "Accountant",
                                icon: Image.asset('assets/accounting.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Graphic Designer",
                                              )));
                                },
                                title: "Graphic Designer",
                                icon: Image.asset('assets/graphic-design.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Driver",
                                              )));
                                },
                                title: "Driver",
                                icon: Image.asset('assets/driver.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableJobRequests(
                                                title: "Cook",
                                              )));
                                },
                                title: "Cook",
                                icon: Image.asset('assets/woman.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    final func = context.read<Global>();
                                    func.setPostIndex(1);
                                  });
                                  //get access to function
                                },
                                child: Text(
                                  "View more",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    thickness: 3,
                    color: Colors.grey[400],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black38,
                        )
                      ]),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Job Request Ads",
                            style: Theme.of(context).textTheme.headlineSmall,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('jobrequests')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Placeholder while loading
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs.take(3).toList();
                            return Column(
                              children: documents.map((doc) {
                                return JobAddCard(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsPost(
                                          jobId: doc.id, // Pass the document ID
                                        ),
                                      ),
                                    );
                                  },
                                  position: doc['name'],
                                  company: doc['category'],
                                  location: doc['district'],
                                  cover: NetworkImage(doc[
                                      'cover']), // Assuming 'coverImageUrl' holds the URL of the cover image
                                );
                              }).toList(),
                            );
                          }
                          return Text('No job positions found.');
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AvailableJobRequests()));
                        },
                        child: Text(
                          'View All Jobs',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
