import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/entities/user_entity.dart';
import '../../models/entities/contact_us_entity.dart';
import '../../models/entities/faq_entity.dart';
import '../../models/entities/privacy_policy_entity.dart';
import '../../models/trip/car_category_entity.dart';

abstract class FirebaseFutures {
  Future<List<FAQEntity>> fetchFAQData();
  Future<List<ContactUsEntity>> fetchContactUs();
  Future<List<PrivacyPolicyEntity>> fetchPrivacyPolicy();
  Future<List<CarCategoryEntity>?> getCarCategory();
  //Future<UserEntity> getUserData(String userID);
  Future<void> getUserDataToHive(String userID);
}

class FireBaseFuturesService implements FirebaseFutures {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<UserEntity> getUserData(String userID) async {
  //   try {
  //     final DocumentSnapshot documentSnapshot =
  //         await _firestore.collection('userData').doc(userID).get();

  //     final data = documentSnapshot.data() as Map<String, dynamic>;
  //     print("Firebase_future: $data");

  //     return UserEntity(
  //       user_ID: data['user_ID'],
  //       full_name: data['full_name'],
  //       photoURL: data['photoURL'] ?? '',
  //       email: data['email'],
  //       phone: data['phone'],
  //       blocked: data['blocked'],
  //       signup_setup_complete: data['blocked'],
  //       deleted_account: data['deleted_account'],
  //       permanently_blocked: data['permanently_blocked'],
  //       emailPassword_auth: data['emailPassword_auth'],
  //       phone_auth_complete: data['phone_auth_complete'],
  //       google_auth: data['google_auth'],
  //       facebook_signUp: data['facebook_signUp'],
  //     );
  //   } catch (e) {
  //     print("Error retrieving user data: $e");
  //     throw e;
  //   }
  // }

  @override
  Future<void> getUserDataToHive(String userID) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await _firestore.collection('userData').doc(userID).get();

      final data = documentSnapshot.data() as Map<String, dynamic>;
      print("Firebase_future: $data");

      final userHive = UserHive(
        user_ID: data['user_ID'],
        full_name: data['full_name'],
        photoURL: data['photoURL'] ?? '',
        email: data['email'],
        phone: data['phone'],
        blocked: data['blocked'],
        signUpComplete: data['signUpComplete'],
        deleted_account: data['deleted_account'],
        permanently_blocked: data['permanently_blocked'],
        emailAuth: data['emailAuth'],
        phoneAuth: data['phoneAuth'],
        googleAuth: data['googleAuth'],
        userRating: data['userRating'] ?? 3.3,
      );

      await boxUserHive.put(userHive.user_ID, userHive);
    } catch (e) {
      print("Error retrieving user data: $e");
      throw e;
    }
  }

  Future<List<FAQEntity>> fetchFAQData() async {
    List<FAQEntity> faqList = [];

    try {
      final walletRef = _firestore.collection('appData').doc('helpCenter');
      final faqRef = walletRef.collection('faqs');

      // Query the documents in the collection
      QuerySnapshot querySnapshot = await faqRef.get();

      querySnapshot.docs.forEach((doc) {
        print("doc");
        print(doc['faqAnswer']);
        FAQEntity faq = FAQEntity(
          faqQuestion: doc['faqQuestion'] ?? '',
          faqAnswer: doc['faqAnswer'] ?? '',
          faqID: doc['faqID'] ?? '',
          faqType: doc['faqType'] ?? '',
        );
        faqList.add(faq);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }

    print(faqList);

    return faqList;
  }

  Future<List<ContactUsEntity>> fetchContactUs() async {
    List<ContactUsEntity> contactList = [];

    try {
      final helpCenterRef = _firestore.collection('appData').doc('helpCenter');
      final contactUs = helpCenterRef.collection('contactUs');

      QuerySnapshot querySnapshot = await contactUs.get();

      querySnapshot.docs.forEach((doc) {
        ContactUsEntity contact = ContactUsEntity(
          contactHandle: doc['contactHandle'] ?? '',
          contactType: doc['contactType'],
          contactID: doc['contactID'] ?? '',
        );
        contactList.add(contact);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }

    print(contactList);
    return contactList;
  }

  Future<List<PrivacyPolicyEntity>> fetchPrivacyPolicy() async {
    List<PrivacyPolicyEntity> policyList = [];

    try {
      final helpCenterRef = _firestore.collection('appData').doc('helpCenter');
      final privacyPolicyRef = helpCenterRef.collection('privacyPolicy');

      QuerySnapshot querySnapshot =
          await privacyPolicyRef.orderBy('policyCode').get();

      querySnapshot.docs.forEach((doc) {
        PrivacyPolicyEntity policy = PrivacyPolicyEntity(
          policyHeader: doc['policyHeader'] ?? '',
          policyBody: doc['policyBody'] ?? '',
          policyCode: doc['policyCode'] ?? '',
          policyID: doc['policyID'] ?? '',
        );
        policyList.add(policy);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }

    print(policyList);
    return policyList;
  }

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////
  ///////////////////////REALTIME DATABASE////////////////////////////
  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  Future<List<CarCategoryEntity>?> getCarCategory() async {
    try {
      final querySnapshot = await _firestore
          .collection('appData')
          .doc('tripUtilities')
          .collection('CarCategory')
          .get(); // Use get() to fetch a single snapshot

      return querySnapshot.docs.map((documentSnapshot) {
        return CarCategoryEntity(
          categoryName: documentSnapshot['categoryName'] ?? '',
          baseFare: documentSnapshot['baseFare'] ?? 0.0,
          perKilometerRate: documentSnapshot['perKilometerRate'] ?? 0.0,
          perMinuteRate: documentSnapshot['perMinuteRate'] ?? 0.0,
          imageURL: documentSnapshot['imageURL'] ?? '',
          availability: documentSnapshot['availability'] ?? false,
          availableCars: documentSnapshot['availableCars'] ?? 0,
        );
      }).toList();
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null or handle the error as needed
    }
  }
}
