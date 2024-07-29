import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/JobsHome/Jobs/jobDetails.dart';
import 'package:plumber/Pages/WholeSaleHome/BuyBulk/bulkDetails.dart';
import 'package:plumber/components/jobAdCard.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AvailableBulks extends StatefulWidget {
  String? title;
  String? location;
  AvailableBulks({super.key, this.title, this.location});

  @override
  State<AvailableBulks> createState() => _AvailableBulksState();
}

class _AvailableBulksState extends State<AvailableBulks> {
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
                ? "All Products"
                : '${widget.title}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: AppTheme.colors.primary,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        AutoSizeText(
                          widget.location == null
                              ? "All of Sri Lanka"
                              : '${widget.location}',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 6,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.file,
                          color: AppTheme.colors.primary,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        AutoSizeText(
                          (widget.title == null || widget.title == '')
                              ? "All Products"
                              : '${widget.title}',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 6,
                        ),
                      ],
                    ),
                    FaIcon(
                      Icons.filter_list,
                      color: AppTheme.colors.primary,
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/jobCover1.jpg')),
              SizedBox(
                height: 20,
              ),
              widget.title == ''
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('bulk')
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
                          return Column(
                            children: snapshot.data!.docs.map((doc) {
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
                                company: "LKR ${doc['price']}.00",
                                location: doc['district'],
                                cover: NetworkImage(doc[
                                    'coverUrl']), // Assuming 'coverImageUrl' holds the URL of the cover image
                              );
                            }).toList(),
                          );
                        }
                        return Text('No products found.');
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('bulk')
                          .where('title',
                              isEqualTo:
                                  widget.title) // Filter by title if not null
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
                          return Column(
                            children: snapshot.data!.docs.map((doc) {
                              return JobAddCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BulkDetails(
                                        jobId: doc.id, // Pass the document ID
                                      ),
                                    ),
                                  );
                                },
                                position: doc['title'],
                                company: "LKR ${doc['price']}.00",
                                location: doc['district'],
                                cover: NetworkImage(doc[
                                    'coverUrl']), // Assuming 'coverImageUrl' holds the URL of the cover image
                              );
                            }).toList(),
                          );
                        }
                        return Text('No products found.');
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
