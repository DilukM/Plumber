import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../utils/themes/theme.dart';

class BulkUploadPage extends StatefulWidget {
  const BulkUploadPage({super.key});

  @override
  State<BulkUploadPage> createState() => _BulkUploadPageState();
}

class _BulkUploadPageState extends State<BulkUploadPage> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  File? jsonFile;
  bool isFilePicked = false;

  Future<void> pickJsonFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (result != null) {
      setState(() {
        jsonFile = File(result.files.single.path!);
        isFilePicked = true;
      });
    }
  }

  Future<void> uploadBulkData() async {
    if (jsonFile == null) return;

    try {
      final String content = await jsonFile!.readAsString();
      final List<dynamic> data = jsonDecode(content);

      final ap = Provider.of<CustomAuthProvider>(context, listen: false);

      for (var item in data) {
        await products.add({
          'uid': ap.uid,
          'title': item['title'],
          'condition': item['condition'],
          'district': item['district'],
          'area': item['area'],
          'brand': item['brand'],
          'model': item['model'],
          'price': item['price'],
          'description': item['description'],
          'category': item['category'],
          'coverUrl': item['coverUrl'],
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      setState(() {
        jsonFile = null;
        isFilePicked = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bulk data uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey[900]),
        title: Text(
          "Bulk Upload Products",
          style: TextStyle(color: Colors.grey[900]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: GestureDetector(
                  onTap: pickJsonFile,
                  child: Container(
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
                    padding: const EdgeInsets.all(12),
                    child: isFilePicked
                        ? Container(
                            height: 200,
                            child: Center(
                              child: Text(
                                'JSON File Selected: ${jsonFile!.path.split('/').last}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Image.asset('assets/post.png')),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Upload Your JSON File',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: Text(
                                      'Click here to upload your JSON file containing product data.\n(.json)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    onPressed: uploadBulkData,
                    child: const Text('Upload Data')),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
