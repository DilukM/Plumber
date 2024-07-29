import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String firstname;
  String lastname;
  String email;
  String phone;
  String uid;
  String imageUrl;
  String createdAt;

  UserModel({
    required this.imageUrl,
    required this.phone,
    required this.uid,
    required this.createdAt,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

//from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        phone: map['phone'] ?? '',
        uid: map['uid'] ?? '',
        createdAt: map['createdAt'] ?? '',
        firstname: map['firstname'] ?? '',
        lastname: map['lastname'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        email: map['email'] ?? '');
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }

  Future<void> uploadUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(uid)
        .set(toMap())
        .then((value) => print("User Data Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
