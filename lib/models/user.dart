import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      profilePictureUrl: doc['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
