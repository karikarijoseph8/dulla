/// Used during registration to keep track of auth data. Should be cleared after
/// completion or registration process
class RegistrationAuthData {
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _photoURL;
  String? _otpCode;

  String? get name => _name;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  String? get password => _password;
  String? get photoURL => _photoURL;
  String? get otpCode => _otpCode;

  void setName(String name) {
    _name = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setPhotoURL(String photoURL) {
    _photoURL = photoURL;
  }

  void setOTPCode(String otpCode) {
    _otpCode = otpCode;
  }

  void clearData() {
    _email = null;
    _name = null;
    _password = null;
    _phoneNumber = null;
    _photoURL = null;
    _otpCode = null;
  }
}
