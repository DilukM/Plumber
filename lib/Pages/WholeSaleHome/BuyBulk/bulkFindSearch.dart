import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/searchCard.dart';
import '../../../global/globalValues.dart';
import '../../../utils/themes/theme.dart';

class BulkFindSearch extends StatefulWidget {
  const BulkFindSearch({super.key});

  @override
  State<BulkFindSearch> createState() => _BulkFindSearchState();
}

class _BulkFindSearchState extends State<BulkFindSearch> {
  final TextEditingController searchController = TextEditingController();
  List<SearchCard> products = [
    SearchCard(
      title: 'Electronics',
      icon: Image.asset('assets/electrician1.png'),
    ),
    SearchCard(
      title: 'Vehicles',
      icon: Image.asset('assets/builder1.png'),
    ),
    SearchCard(
      title: 'Property',
      icon: Image.asset('assets/carpenter1.png'),
    ),
    SearchCard(
      title: 'Home & Garden',
      icon: Image.asset('assets/driver1.png'),
    ),
    SearchCard(
      title: 'Animals',
      icon: Image.asset('assets/graphic-designer1.png'),
    ),
    SearchCard(
      title: 'Servicese',
      icon: Image.asset('assets/data-entry.png'),
    ),
    SearchCard(
      title: 'Business & Industry',
      icon: Image.asset('assets/electrician1.png'),
    ),
    SearchCard(
      title: 'Jobs',
      icon: Image.asset('assets/builder1.png'),
    ),
    SearchCard(
      title: 'Hobby, Sport & Kids',
      icon: Image.asset('assets/carpenter1.png'),
    ),
    SearchCard(
      title: 'Fashion & Beauty',
      icon: Image.asset('assets/driver1.png'),
    ),
    SearchCard(
      title: 'Essentials',
      icon: Image.asset('assets/graphic-designer1.png'),
    ),
    SearchCard(
      title: 'Education',
      icon: Image.asset('assets/data-entry.png'),
    ),
    SearchCard(
      title: 'Agriculture',
      icon: Image.asset('assets/electrician1.png'),
    ),
    SearchCard(
      title: 'Others',
      icon: Image.asset('assets/builder1.png'),
    ),

    // Add more products as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: Column(
          children: [
            Container(
              height: 150,
              color: AppTheme.colors.primary,
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                child: TextField(
                  controller: searchController,
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
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 245, 196, 217))),
                    ),
                    suffixIconColor: Colors.black,
                    labelText: 'What are you looking for?',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SearchCard(
                          onTap: () {
                            Navigator.pushNamed(context, '/home');
                            final func = context.read<Global>();
                            func.setFindJobsIndex(2);
                            func.setMainIndex(0);
                          },
                          title: products[index].title,
                          icon: products[index].icon,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 65,
            )
          ],
        ),
      ),
    );
  }
}
