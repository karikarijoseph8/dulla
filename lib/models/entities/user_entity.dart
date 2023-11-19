class UserEntity {
  late String user_ID;
  late String full_name;
  late String photoURL;
  late String email;
  late String phone;
  //Blocking
  late bool blocked;
  late bool deleted_account;
  late bool permanently_blocked;
  //Auth
  late bool signUpComplete;
  late bool emailAuth;
  late bool phoneAuth;
  late bool googleAuth;
  late double userRating;

  UserEntity({
    required this.user_ID,
    required this.full_name,
    required this.photoURL,
    required this.email,
    required this.phone,
    required this.blocked,
    required this.deleted_account,
    required this.permanently_blocked,
    required this.signUpComplete,
    required this.emailAuth,
    required this.phoneAuth,
    required this.googleAuth,
    required this.userRating,
  });
}
