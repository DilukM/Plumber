import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/Jobs/availableJobs.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class BrowseJobs extends StatefulWidget {
  const BrowseJobs({super.key});

  @override
  State<BrowseJobs> createState() => _BrowseJobsState();
}

class _BrowseJobsState extends State<BrowseJobs> {
  final TextEditingController searchController = TextEditingController();
  List<String> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobCategories();
  }

  Future<void> fetchJobCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('jobCategories').get();
      setState(() {
        items = querySnapshot.docs.map((doc) => doc['name'] as String).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching job categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching job categories: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterSearchResults(String query) {
    List<String> searchResult = [];
    if (query.isNotEmpty) {
      searchResult = items
          .where((jobCategory) =>
              jobCategory.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        items = searchResult;
      });
    } else {
      setState(() {
        fetchJobCategories();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            color: AppTheme.colors.primary,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.transparent),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      filterSearchResults('');
                    },
                    icon: const Icon(Icons.clear),
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 245, 196, 217)),
                    ),
                  ),
                  suffixIconColor: Colors.black,
                  labelText: 'What are you looking for?',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         blurRadius: 8,
          //         color: Colors.black38,
          //       )
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           FaIcon(
          //             FontAwesomeIcons.locationDot,
          //             color: AppTheme.colors.primary,
          //           ),
          //           const SizedBox(
          //             width: 5,
          //           ),
          //           const AutoSizeText(
          //             "All of Sri Lanka",
          //             overflow: TextOverflow.fade,
          //             maxLines: 1,
          //             maxFontSize: 12,
          //             minFontSize: 6,
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           FaIcon(
          //             FontAwesomeIcons.file,
          //             color: AppTheme.colors.primary,
          //           ),
          //           const SizedBox(
          //             width: 5,
          //           ),
          //           const AutoSizeText(
          //             "Data Entry Operator",
          //             overflow: TextOverflow.fade,
          //             maxLines: 1,
          //             maxFontSize: 12,
          //             minFontSize: 6,
          //           ),
          //         ],
          //       ),
          //       FaIcon(
          //         Icons.filter_list,
          //         color: AppTheme.colors.primary,
          //       ),
          //     ],
          //   ),
          // ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Browse Jobs",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AvailableJobs(title: items[index]),
                      ),
                    );
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[600],
                  ),
                  title: Text(
                    items[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
