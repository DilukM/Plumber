import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/Jobs/availableJobs.dart';
import 'package:plumber/Pages/JobsHome/Jobs/jobDetails.dart';
import 'package:plumber/components/jobAdCard.dart';
import 'package:plumber/components/jobCategoryCard.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FindJobsHome extends StatefulWidget {
  const FindJobsHome({super.key});

  @override
  State<FindJobsHome> createState() => _FindJobsHomeState();
}

class _FindJobsHomeState extends State<FindJobsHome> {
  final TextEditingController jobController = TextEditingController();
  final SingleValueDropDownController locationController =
      SingleValueDropDownController();
  String? location;

  List<DropDownValueModel> dropDownList = [
    DropDownValueModel(name: 'Western Province', value: "Western Province"),
    DropDownValueModel(name: 'Central Province', value: "Central Province"),
    DropDownValueModel(name: 'Northern Province', value: "Northern Province"),
    DropDownValueModel(
        name: 'North Central Province', value: "North Central Province"),
    DropDownValueModel(name: 'Eastern Province', value: "Eastern Province"),
    DropDownValueModel(
        name: 'North Western Province', value: "North Western Province"),
    DropDownValueModel(
        name: 'Sabaragamuwa Province', value: "Sabaragamuwa Province"),
    DropDownValueModel(name: 'Southern Province', value: "Southern Province"),
    DropDownValueModel(name: 'Uva Province', value: "Uva Province"),
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
                    labelText: 'Find Jobs',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // DropDownTextField(
                //   controller: locationController,
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
                // ),
                // SizedBox(
                //   height: 12,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvailableJobs(
                                    title: jobController.text,
                                    location:
                                        locationController.dropDownValue?.value,
                                  )));
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Featured Employers",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/Pizza_Hut.png'),
                    Image.asset('assets/hemas.png'),
                    Image.asset('assets/keells.png'),
                    Image.asset('assets/sampath.png'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Divider(
                    thickness: 3,
                    color: AppTheme.colors.primary,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                //   child: Divider(
                //     thickness: 3,
                //     color: AppTheme.colors.primary,
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Column(
                //       children: [
                //         Image.asset('assets/resume.png'),
                //         Text("Resume"),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Image.asset('assets/letter.png'),
                //         Text("Letter"),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Image.asset('assets/application.png'),
                //         Text("Application"),
                //       ],
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                //   child: Divider(
                //     thickness: 3,
                //     color: AppTheme.colors.primary,
                //   ),
                // ),
                SizedBox(height: 12),
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
                              "Browse Jobs",
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                          builder: (context) => AvailableJobs(
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
                                  //get access to function
                                  final func = context.read<Global>();
                                  func.setFindJobsIndex(1);
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
                            "Job Ads",
                            style: Theme.of(context).textTheme.headlineSmall,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('jobpositions')
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
                                        builder: (context) => JobDetails(
                                          jobId: doc.id, // Pass the document ID
                                        ),
                                      ),
                                    );
                                  },
                                  position: doc['title'],
                                  company: doc['company'],
                                  location: doc['district'],
                                  cover: NetworkImage(doc[
                                      'coverUrl']), // Assuming 'coverImageUrl' holds the URL of the cover image
                                );
                              }).toList(),
                            );
                          }
                          return Text('No job positions found.');
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          final func = context.read<Global>();
                          func.setFindJobsIndex(2);
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
