import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/ServicesHome/BuyServices/availableServices.dart';
import 'package:plumber/Pages/ServicesHome/BuyServices/serviceDetails.dart';
import 'package:plumber/components/jobAdCard.dart';
import 'package:plumber/components/jobCategoryCard.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../global/globalValues.dart';
import '../../../utils/themes/theme.dart';

class FindServicesHome extends StatefulWidget {
  const FindServicesHome({super.key});

  @override
  State<FindServicesHome> createState() => _FindServicesHomeState();
}

class _FindServicesHomeState extends State<FindServicesHome> {
  final TextEditingController jobController = TextEditingController();
  final SingleValueDropDownController locationController =
      SingleValueDropDownController();
  String? location;

  List<DropDownValueModel> dropDownList = [
    const DropDownValueModel(
        name: 'Western Province', value: "Western Province"),
    const DropDownValueModel(
        name: 'Central Province', value: "Central Province"),
    const DropDownValueModel(
        name: 'Northern Province', value: "Northern Province"),
    const DropDownValueModel(
        name: 'North Central Province', value: "North Central Province"),
    const DropDownValueModel(
        name: 'Eastern Province', value: "Eastern Province"),
    const DropDownValueModel(
        name: 'North Western Province', value: "North Western Province"),
    const DropDownValueModel(
        name: 'Sabaragamuwa Province', value: "Sabaragamuwa Province"),
    const DropDownValueModel(
        name: 'Southern Province', value: "Southern Province"),
    const DropDownValueModel(name: 'Uva Province', value: "Uva Province"),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0, right: 12, left: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Find Services',
                  ),
                ),
                const SizedBox(
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
                              builder: (context) => AvailableServices(
                                    title: jobController.text,
                                    location:
                                        locationController.dropDownValue?.value,
                                  )));
                    },
                    child: const Text("Search"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    thickness: 3,
                    color: AppTheme.colors.primary,
                  ),
                ),

                const SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
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
                              "Browse Services",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        const SizedBox(
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
                                              AvailableServices(
                                                title: "Grsphic Designing",
                                              )));
                                },
                                title: "Grsphic Designing",
                                icon: Image.asset('assets/data-entry.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableServices(
                                                title: "Video Editing",
                                              )));
                                },
                                title: "Video Editing",
                                icon: Image.asset('assets/sales.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableServices(
                                                title: "Digital Marketing",
                                              )));
                                },
                                title: "Digital Marketing",
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
                                              AvailableServices(
                                                title: "Web Development",
                                              )));
                                },
                                title: "Web Development",
                                icon: Image.asset('assets/check-in.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableServices(
                                                title: "Car Wash",
                                              )));
                                },
                                title: "Car Wash",
                                icon: Image.asset('assets/recruitment.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableServices(
                                                title: "Computer Repairing",
                                              )));
                                },
                                title: "Computer Repairing",
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
                                              AvailableServices(
                                                title: "Plumbing",
                                              )));
                                },
                                title: "Plumbing",
                                icon: Image.asset('assets/graphic-design.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableServices(
                                                title: "Beauty Salon",
                                              )));
                                },
                                title: "Beauty Salon",
                                icon: Image.asset('assets/driver.png'),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4),
                            JobCategoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvailableServices(
                                                title: "Mason",
                                              )));
                                },
                                title: "Mason",
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
                                child: const Text(
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
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black38,
                        )
                      ]),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('services')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Placeholder while loading
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
                                        builder: (context) => ServiceDetails(
                                          jobId: doc.id, // Pass the document ID
                                        ),
                                      ),
                                    );
                                  },
                                  position: doc['title'],
                                  company: doc['category'],
                                  location: "LKR ${doc['price']}.00",
                                  cover: NetworkImage(doc['coverUrl']) ??
                                      const AssetImage(
                                          'assets/placeholder.jpg'), // Assuming 'coverImageUrl' holds the URL of the cover image
                                );
                              }).toList(),
                            );
                          }
                          return const Text('No services found.');
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          final func = context.read<Global>();
                          func.setFindJobsIndex(2);
                        },
                        child: const Text(
                          'View All Services',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
