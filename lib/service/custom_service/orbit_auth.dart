import 'dart:async';

import '../../models/phone_auth_user.dart';

class OrbitAuth {
  final StreamController<OrbitAuthUser?> _userController =
      StreamController<OrbitAuthUser?>();

  Stream<OrbitAuthUser?> get authStateChanges => _userController.stream;

  OrbitAuthUser? _currentOrbitCustomAuthUser;

  // OrbitCustomAuthUser? getCurrentUser() {
  //   return _currentOrbitCustomAuthUser;
  // }

  OrbitAuth() {
    // Simulate user login status when the Auth class is created.
    _currentOrbitCustomAuthUser = null;
    _userController.add(_currentOrbitCustomAuthUser);
  }

  Future<OrbitAuthUser?> signInWithEmailAndPassword(
      String email, String password) async {
    // Simulate user([]) authentication here.
    // You can implement your own logic for validation and user management.
    // For simplicity, we'll just return a user with a dummy UID.
    await Future.delayed(Duration(seconds: 2));
    // _currentUser = User(uid: 'dummyUID');
    _userController.add(_currentOrbitCustomAuthUser);
    return _currentOrbitCustomAuthUser;
  }

  Future<OrbitAuthUser?> signInWithPhone(String phoneNumber) async {
    // Simulate phone authentication here.
    // In a real app, you would validate the code with an external service.
    // For simplicity, we'll just return a user with a dummy UID.
    await Future.delayed(Duration(seconds: 2));
    _currentOrbitCustomAuthUser = OrbitAuthUser(
        uid: 'dummyUID', phoneNumber: phoneNumber, token: 'rgsrgfffsf');
    _userController.add(_currentOrbitCustomAuthUser);
    return _currentOrbitCustomAuthUser;
  }

  Future<void> signOut() async {
    // Simulate user sign-out.
    await Future.delayed(Duration(seconds: 1));
    _currentOrbitCustomAuthUser = null;
    _userController.add(_currentOrbitCustomAuthUser);
  }
}

// class User {
//   final String uid;

//   User({required this.uid});
// }
