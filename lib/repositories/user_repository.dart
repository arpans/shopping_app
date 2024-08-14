import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shopping_app/models/user.dart';

class UserRepository {
  final FirebaseFirestore _fireStore;
  final firebase_auth.FirebaseAuth _auth;

  UserRepository({FirebaseFirestore? fireStore, firebase_auth.FirebaseAuth? auth})
      : _fireStore = fireStore ?? FirebaseFirestore.instance,
        _auth = auth ?? firebase_auth.FirebaseAuth.instance;

  Future<User> fetchUserProfile() async {
    try {
      final firebase_auth.User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No user logged in');
      }

      final DocumentSnapshot doc = await _fireStore.collection('users').doc(currentUser.uid).get();
      return User.fromDocument(doc);
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  Future<User> updateUserProfile({
    required String name,
    required String email,
    required String profilePictureUrl,
  }) async {
    try {
      final firebase_auth.User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No user logged in');
      }

      final user = User(
        id: currentUser.uid,
        name: name,
        email: email,
        profilePictureUrl: profilePictureUrl,
      );

      await _fireStore.collection('users').doc(currentUser.uid).set(user.toMap(), SetOptions(merge: true));

      return user;
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }
}
