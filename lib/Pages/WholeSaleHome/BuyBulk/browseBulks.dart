import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/PostJob/availableJobRequests.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class BrowseBulks extends StatefulWidget {
  const BrowseBulks({super.key});

  @override
  State<BrowseBulks> createState() => _BrowseBulksState();
}

class _BrowseBulksState extends State<BrowseBulks> {
  final TextEditingController searchController = TextEditingController();
  List<String> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBulkCategories();
  }

  Future<void> fetchBulkCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('bulkCategories').get();
      setState(() {
        items = querySnapshot.docs.map((doc) => doc['name'] as String).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching bulk categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching bulk categories: $e')),
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
        fetchBulkCategories();
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
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Browse Bulk Products",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AvailableJobRequests(title: items[index]),
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
