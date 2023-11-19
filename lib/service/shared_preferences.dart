import 'package:orbit/constants/global_contants.dart';
import '../models/entities/user_entity.dart';

class SharePrefercesHlper {
  Future<void> setUserDetail(UserEntity userEntity) async {
    await sharedPref.setString("USERNAME", userEntity.full_name);
    await sharedPref.setString("PHOTOURL", userEntity.photoURL);
    await sharedPref.setString("PHONE", userEntity.phone);
    await sharedPref.setString("EMAIL", userEntity.email);
    await sharedPref.setString("USERID", userEntity.user_ID);
  }

  Future<void> setEmailAuthDetails(String fullName, String phone) async {
    print("Setting Email Auth Details: ${fullName} ${phone}");
    await sharedPref.setString("EMAIL_USERNAME", fullName);
    await sharedPref.setString("EMAIL_PHONE", phone);
  }

  Future<void> setGoogleAuthDetails(String phone) async {
    await sharedPref.setString("GOOGLE_PHONE", phone);
  }

  Future<void> setUserSignInData(phone) async {
    await sharedPref.setString("PHONE", phone);
    // await sharedPref.setString("USERID", userID);
  }
}
