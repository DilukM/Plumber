import 'package:plumber/Pages/WholeSaleHome/SellProduct/editAd.dart';
import 'package:plumber/components/adCard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellBulksHome extends StatefulWidget {
  @override
  _SellBulksHomeState createState() => _SellBulksHomeState();
}

class _SellBulksHomeState extends State<SellBulksHome> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('bulk');

  void deleteAd(String adId, String coverUrl) async {
    try {
      // Delete the image from Firebase Storage
      await FirebaseStorage.instance.refFromURL(coverUrl).delete();
      // Delete the document from Firestore
      await products.doc(adId).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ad deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete ad: $e')));
    }
  }

  void editAd(DocumentSnapshot adData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBulkAdScreen(adData: adData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Ongoing Ads',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final ads = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final adData = ads[index];
              return AdCard(
                adData: adData,
                onDelete: () => deleteAd(adData.id, adData['coverUrl']),
                onEdit: () => editAd(adData),
              );
            },
          );
        },
      ),
    );
  }
}
