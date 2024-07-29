import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plumber/components/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../../global/globalValues.dart';
import '../../../provider/auth_provider.dart';
import '../../../utils/themes/theme.dart';

class ServiceRequestPost extends StatefulWidget {
  const ServiceRequestPost({super.key});

  @override
  State<ServiceRequestPost> createState() => _ServiceRequestPostState();
}

class _ServiceRequestPostState extends State<ServiceRequestPost> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController qualificationsController =
      TextEditingController();

  final CollectionReference jobrequests =
      FirebaseFirestore.instance.collection('jobrequests');
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  File? resumeFile;
  String? resumeUrl;
  bool isResumeUploaded = false;
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
    if (result != null) {
      setState(() {
        resumeFile = File(result.files.single.path!);
        isResumeUploaded = true;
      });
    }
  }

  Future<void> pickCover() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        coverFile = File(result.files.single.path!);
        isCoverUploaded = true;
      });
    }
  }

  Future<void> uploadCover() async {
    if (coverFile == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final resumeRef = storageRef.child(
        'covers/${DateTime.now().millisecondsSinceEpoch}_${coverFile!.path.split('/').last}');
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

  Future<void> uploadResume() async {
    if (resumeFile == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final resumeRef = storageRef.child(
        'resumes/${DateTime.now().millisecondsSinceEpoch}_${resumeFile!.path.split('/').last}');
    final uploadTask = resumeRef.putFile(resumeFile!);

    final snapshot = await uploadTask.whenComplete(() {});
    resumeUrl = await snapshot.ref.getDownloadURL();
  }

  void submitJobPost() async {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);
    try {
      await uploadResume();
      await uploadCover();
      await jobrequests.add({
        'uid': ap.uid,
        'name': nameController.text,
        'age': ageController.text,
        'district': districtController.text,
        'location': locationController.text,
        'description': descriptionController.text,
        'category': selectedCategory,
        'qualifications': qualificationsController.text,
        'cover': coverUrl,
        'experience': experienceController.text,
        'resumeUrl': resumeUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the resume file and URL after submission
      setState(() {
        resumeFile = null;
        resumeUrl = null;
        isResumeUploaded = false;
        coverFile = null;
        coverUrl = null;
        isCoverUploaded = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Job post submitted successfully')),
      );

      // Clear the text fields
      nameController.clear();
      ageController.clear();
      districtController.clear();
      locationController.clear();
      descriptionController.clear();
      categoryController.clear();
      experienceController.clear();
      qualificationsController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit job post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            final func = context.read<Global>();
            func.setPostIndex(0);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Post Your Job Ad Request",
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
                  onTap: pickCover,
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
                                    image: AssetImage(coverFile!.path))),
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
                                    'Upload Your Cover Image',
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
                    child: Row(
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
                              isResumeUploaded
                                  ? 'File selected'
                                  : 'Upload Your Resume',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: AutoSizeText(
                                maxFontSize: 12,
                                maxLines: 2,
                                minFontSize: 6,
                                isResumeUploaded
                                    ? '$resumeFile'
                                    : 'Click here to upload your resume.\n(.pdf / .docx / .doc)',
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
                title: "Name",
                label: "Enter your name here",
                controller: nameController,
              ),
              CustomTextField(
                title: "Age",
                label: "Enter your age here",
                controller: ageController,
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
                          'Location',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        controller: locationController,
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
                          label: Text("Enter your location here"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Use current location')),
                      ),
                    ],
                  ),
                ),
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
                          'Qualifications',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        controller: qualificationsController,
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
                          label: Text("Enter your qualifications here"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextField(
                title: "Experience",
                label: "Enter your experience here",
                controller: experienceController,
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
                      TextField(
                        controller: descriptionController,
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
                          label: Text("Enter your job description here"),
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
