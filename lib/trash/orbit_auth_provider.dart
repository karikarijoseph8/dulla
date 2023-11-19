import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orbit/models/phone_auth_user.dart';

class OrbitAuthProvider extends ChangeNotifier {
  OrbitAuthUser? _currentUser;

  // StreamController<OrbitAuthUser?> _userController =
  //     StreamController<OrbitAuthUser?>();

  OrbitAuthUser? get currentUser => _currentUser;

  OrbitAuthProvider() {
    // Simulate user login status when the Auth class is created.
    _currentUser = null;
    setCurrentUser(_currentUser);
  }

  // Stream<OrbitAuthUser?> get userStream => _userController.stream;

  // Method to sign in with a phone number and verification code.
  Future<void> signInWithPhone(String phoneNumber) async {
    await Future.delayed(Duration(seconds: 2));
    _currentUser = OrbitAuthUser(
        uid: 'dummyUID', phoneNumber: phoneNumber, token: 'ferererer');
    print("Setting User with: $phoneNumber");

    setCurrentUser(_currentUser);
  }

  // Method to set the current user and notify listeners.
  void setCurrentUser(OrbitAuthUser? user) {
    _currentUser = user;
    //_userController.add(user);
    notifyListeners();
  }

  // Method to sign out.
  void signOut() {
    _currentUser = null;
    notifyListeners(); // Notify listeners of the change in authentication state.
  }

  // Dispose the StreamController when it's no longer needed.
  // @override
  // void dispose() {
  //  // _userController.close();
  //   super.dispose();
  // }
}
