import 'package:hive/hive.dart';

part 'userhive.g.dart';

@HiveType(typeId: 1)
class UserHive {
  UserHive({
    required this.user_ID,
    required this.full_name,
    required this.photoURL,
    required this.email,
    required this.phone,
    //Blockings
    required this.blocked,
    required this.deleted_account,
    required this.permanently_blocked,
    //Auths
    required this.signUpComplete,
    required this.emailAuth,
    required this.phoneAuth,
    required this.googleAuth,
    required this.userRating,
  });
  @HiveField(0)
  String user_ID;

  @HiveField(1)
  String full_name;

  @HiveField(2)
  String photoURL;

  @HiveField(3)
  String email;

  @HiveField(4)
  String phone;

  @HiveField(5)
  bool blocked;

  @HiveField(6)
  bool deleted_account;

  @HiveField(7)
  bool permanently_blocked;

  @HiveField(8)
  bool signUpComplete;

  @HiveField(9)
  bool emailAuth;

  @HiveField(10)
  bool phoneAuth;

  @HiveField(11)
  bool googleAuth;

  @HiveField(12)
  double userRating;
}

@HiveType(typeId: 2)
class LocationHive {
  LocationHive({
    required this.latitude,
    required this.longitude,
  });

  @HiveField(0)
  double latitude;
  @HiveField(1)
  double longitude;
}

@HiveType(typeId: 3)
class PickUpAddressHive {
  PickUpAddressHive({
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.placeId,
    required this.placeFormattedAddress,
  });

  @HiveField(0)
  String? placeName;
  @HiveField(1)
  double? latitude;
  @HiveField(2)
  double? longitude;
  @HiveField(3)
  String? placeId;
  @HiveField(4)
  String? placeFormattedAddress;
}
