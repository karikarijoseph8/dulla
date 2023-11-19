import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orbit/models/phone_auth_user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _firebaseAuth.idTokenChanges();
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  late GoogleSignInAccount currentUser;

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    // await credential.user!.updateDisplayName(name);
  }

  Future<GoogleSignInAccount> signinWithGoogle() async {
    // GoogleSignInAccount currentUser;
    try {
      currentUser = (await _googleSignIn.signIn())!;

      print("Google Signing...");
      print(currentUser.displayName);
      print(currentUser.email);
      print(currentUser.id);
      print(currentUser.photoUrl);
      //print(currentUser.authentication);
      //print(currentUser.serverAuthCode);

      print('Credential');
      //print(credential);
      //Finally, Signing In

      return currentUser;
    } catch (error) {
      return currentUser;
    }
  }

  Future<String> signInWithCredential(OAuthCredential credential) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unknown Error';
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    print("LoginResult START");
    final LoginResult result = await _facebookAuth.login(
      permissions: [
        'public_profile',
        'email',
        'pages_show_list',
        'pages_messaging',
        'pages_manage_metadata'
      ],
    );
    print("LoginResult END");

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
    } else {
      print("ERROR");
      print(result.status);
      print(result.message);
    }

    // Create a credential from the access token
    print("OAuthCredential START");
    final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    print("OAuthCredential END");

    // Once signed in, return the UserCredential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  // Future<void> createUserWithEmailAndPassword(
  //     String email, String password, String name, String phoneNumber) async {
  //   UserCredential credential = await _firebaseAuth
  //       .createUserWithEmailAndPassword(email: email, password: password);
  //   await credential.user!.updateDisplayName(name);
  // }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
      // If successful, the user is logged out
    } catch (e) {
      // Handle any errors that occur during logout
      print("Error during logout: $e");
    }
  }
}
