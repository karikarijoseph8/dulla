import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserExistCheckerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userID;

  Future<String> checkGoogleAuthUserExists(
      BuildContext context, String email) async {
    return _firestore
        .collection('userData')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return 'NewUser';
      } else {
        userID = value.docs[0].id;

        print("User Exist with ID:$userID");

        return _firestore
            .collection('userData')
            .doc(userID)
            .get()
            .then((signInMethod) {
          //Checking if Email-SignInMethod-Was-Used
          final bool? emailAuthMethodValue = signInMethod.get('emailAuth');
          if (emailAuthMethodValue == true) {
            return "EmailAuthUsed";
          } else {
            //Checking if EmailPassword-SignInMethod-Was-Used

            return _firestore
                .collection('userData')
                .doc(userID)
                .get()
                .then((signInMethod) {
              final bool? phoneAuthMethodValue = signInMethod.get('phoneAuth');
              if (phoneAuthMethodValue == true) {
                return "phoneAuthWasUsed";
              } else {
                return _firestore
                    .collection('userData')
                    .doc(userID)
                    .get()
                    .then((signInMethod) {
                  final bool? googleAuthMethodValue =
                      signInMethod.get('googleAuth');
                  if (googleAuthMethodValue == true) {
                    //Checking if PhoneAuth-Is-Completed
                    return "GoogleAuthUsed-Completed";
                  } else {
                    return _firestore
                        .collection('driverData')
                        .where('email', isEqualTo: email)
                        .get()
                        .then((value) {
                      if (value.docs.isNotEmpty) {
                        return "Registered-Driver";
                      } else {
                        return "Use-Another-Email";
                        //Checking if EmailPassword-SignInMethod-Was-Used
                      }
                    });

                    //Checking if EmailPassword-SignInMethod-Was-Used
                  }
                });
              }
            });
          }
        });
      }
    });
  }
}
