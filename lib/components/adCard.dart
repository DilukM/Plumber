import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdCard extends StatelessWidget {
  final DocumentSnapshot adData;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  AdCard({required this.adData, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                adData['coverUrl'] != null
                    ? Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(adData['coverUrl']))),
                      )
                    : Container(),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: AutoSizeText(
                        maxFontSize: 20,
                        minFontSize: 10,
                        adData['title'] ?? 'No Title',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('LKR ${adData['price'] ?? 'N/A'}'),
                    SizedBox(height: 5),
                    Text('${adData['category'] ?? 'N/A'}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ElevatedButton(
                    onPressed: onEdit,
                    child: Text('Edit'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ElevatedButton(
                    onPressed: onDelete,
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        side: BorderSide(color: Colors.transparent)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
