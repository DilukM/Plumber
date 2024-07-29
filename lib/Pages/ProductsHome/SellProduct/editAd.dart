// ignore_for_file: unused_import

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:plumber/components/customTextfield.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditAdScreen extends StatefulWidget {
  final DocumentSnapshot adData;

  EditAdScreen({required this.adData});

  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  File? coverFile;
  String? coverUrl;
  bool isCoverUploaded = false;
  String? selectedCategory;
  List<String> categories = [];
  bool isAddingNewCategory = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    titleController.text = widget.adData['title'];
    descriptionController.text = widget.adData['description'];
    priceController.text = widget.adData['price'];
    conditionController.text = widget.adData['condition'];
    brandController.text = widget.adData['brand'];
    modelController.text = widget.adData['model'];
    areaController.text = widget.adData['area'];
    categoryController.text = widget.adData['category'];
    districtController.text = widget.adData['district'];
    coverUrl = widget.adData['coverUrl'];
  }

  Future<void> fetchCategories() async {
    final snapshot = await categoriesCollection.get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  Future<void> pickResume() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        coverFile = File(result.files.single.path!);
        isCoverUploaded = true;
      });
    }
  }

  Future<void> uploadResume() async {
    if (coverFile == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final resumeRef = storageRef.child(
        'ProductCovers/${DateTime.now().millisecondsSinceEpoch}_${coverFile!.path.split('/').last}');
    final uploadTask = resumeRef.putFile(coverFile!);

    final snapshot = await uploadTask.whenComplete(() {});
    coverUrl = await snapshot.ref.getDownloadURL();
  }

  Future<void> addNewCategory(String newCategory) async {
    await categoriesCollection.add({'name': newCategory});
    setState(() {
      categories.add(newCategory);
      selectedCategory = newCategory;
      isAddingNewCategory = false;
    });
  }

  void saveEdits() async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.adData.id)
          .update({
        'title': titleController.text,
        'condition': conditionController.text,
        'district': districtController.text,
        'area': areaController.text,
        'brand': brandController.text,
        'model': modelController.text,
        'price': priceController.text,
        'description': descriptionController.text,
        'coverUrl': coverUrl,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ad updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update ad: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Ad',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
                  onTap: pickResume,
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
                      child: isCoverUploaded
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(coverFile!))),
                            )
                          : Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(coverUrl!))),
                            )),
                ),
              ),
              CustomTextField(
                title: "Title",
                label: "Enter product title here",
                controller: titleController,
              ),
              CustomTextField(
                title: "Brand",
                label: "Enter product brand here",
                controller: brandController,
              ),
              CustomTextField(
                title: "Model",
                label: "Enter product model here",
                controller: modelController,
              ),
              CustomTextField(
                title: "Condition",
                label: "Enter the condition of the product",
                controller: conditionController,
              ),
              CustomTextField(
                title: "Price",
                label: "Enter product price here",
                controller: priceController,
              ),
              CustomTextField(
                title: "District",
                label: "Enter your district here",
                controller: districtController,
              ),
              CustomTextField(
                title: "Area",
                label: "Enter your area here",
                controller: areaController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        maxLines: 10,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppTheme.colors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppTheme.colors.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppTheme.colors.primary),
                          ),
                          alignLabelWithHint: true,
                          label:
                              const Text("Enter your product description here"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    onPressed: saveEdits, child: const Text('Update')),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
