import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plumber/components/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../../provider/auth_provider.dart';
import '../../../utils/themes/theme.dart';

class SellServicePost extends StatefulWidget {
  const SellServicePost({super.key});

  @override
  State<SellServicePost> createState() => _SellServicePostState();
}

class _SellServicePostState extends State<SellServicePost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final CollectionReference services =
      FirebaseFirestore.instance.collection('services');
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('serviceCategories');

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
        'ServiceCovers/${DateTime.now().millisecondsSinceEpoch}_${coverFile!.path.split('/').last}');
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

  void submitJobPost() async {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    try {
      await uploadResume();
      await services.add({
        'uid': ap.uid,
        'title': titleController.text,
        'district': districtController.text,
        'area': areaController.text,
        'price': priceController.text,
        'description': descriptionController.text,
        'category': selectedCategory,
        'coverUrl': coverUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the resume file and URL after submission
      setState(() {
        coverFile = null;
        coverUrl = null;
        isCoverUploaded = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service submitted successfully')),
      );

      // Clear the text fields
      titleController.clear();
      districtController.clear();
      areaController.clear();
      descriptionController.clear();
      categoryController.clear();
      priceController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Post a Service",
          style: TextStyle(color: Colors.white),
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
                        : Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Image.asset('assets/post.png')),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    maxFontSize: 14,
                                    minFontSize: 10,
                                    'Upload Your Image',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: AutoSizeText(
                                      maxFontSize: 12,
                                      maxLines: 2,
                                      minFontSize: 6,
                                      'Click here to upload your cover image.\n(.png / .jpg / .jpeg)',
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
              CustomTextField(
                title: "Title",
                label: "Enter service title here",
                controller: titleController,
              ),
              CustomTextField(
                title: "Hourly rate",
                label: "Enter rate here",
                controller: priceController,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Category',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        items: [
                          ...categories.map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              )),
                          DropdownMenuItem(
                            value: "Add New Category",
                            child: Text("Add New Category"),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value == "Add New Category") {
                              isAddingNewCategory = true;
                              selectedCategory = null;
                            } else {
                              isAddingNewCategory = false;
                              selectedCategory = value;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppTheme.colors.primary),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppTheme.colors.primary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppTheme.colors.primary),
                          ),
                          label: Text("Select or enter a new category"),
                        ),
                      ),
                      if (isAddingNewCategory)
                        TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: AppTheme.colors.primary),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: AppTheme.colors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppTheme.colors.primary),
                            ),
                            label: Text("Enter a new category"),
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              addNewCategory(value);
                              categoryController.clear();
                            }
                          },
                        ),
                    ],
                  ),
                ),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
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
                          label: Text("Enter your description here"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    onPressed: submitJobPost, child: const Text('Submit')),
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
