import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/entities/user_entity.dart';

class StreamPreloader {
  final StreamController<UserEntity> userController =
      StreamController<UserEntity>();

  Future<void> preloadUserData(String userId) async {
    try {
      // Fetch user data from Firebase Firestore
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(userId)
              .get();

      if (userSnapshot.exists) {
        final data = userSnapshot.data();
        print(data);

        // Create a UserEntity object from the fetched data
        final UserEntity user = UserEntity(
          user_ID: data!['user_ID'],
          full_name: data['full_name'],
          photoURL: data['photoURL'] ?? '',
          email: data['email'],
          phone: data['phone'],
          blocked: data['blocked'],
          signUpComplete: data['signUpComplete'],
          deleted_account: data['deleted_account'],
          permanently_blocked: data['permanently_blocked'],
          emailAuth: data['emailAuth'],
          googleAuth: data['googleAuth'],
          phoneAuth: data['phoneAuth'],
          userRating: data['userRating'] ?? 3.3,
        );

        // Add the UserEntity object to the stream
        userController.add(user);
      } else {
        print("User not found in Firestore");
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }
}
