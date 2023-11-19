import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/textfields/authTextField.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/service/providers/firebase_service.dart';
import 'package:orbit/service/providers/userExist_checker_service.dart';
import 'package:orbit/service/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../components/app_alerts_dialogs.dart';
import '../../../components/customfont/customfonts.dart';
import 'otp_signin_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  GoogleSignInAccount? currentGoogleUser;

  FirebaseAuth auth = FirebaseAuth.instance;
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.light;
  @override
  void initState() {
    setupInitialUI();
    super.initState();
  }

  Future<void> setupInitialUI() async {
    _currentStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.mainWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentStyle,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Enter your",
                  style: GoogleFonts.urbanist(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Phone",
                  style: GoogleFonts.urbanist(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Image.asset(
                                    "assets/icons/gh.png",
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "+233",
                                    style: CustomFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: PhoneAuthTextFormField(
                                  controller: phoneController,
                                  hint: 'Enter phone number',
                                  keyboardType: TextInputType.phone,
                                  style: CustomFonts.urbanist(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: SubmitButton(
                          onPressed: () {
                            if (phoneController.text.length < 10) {
                              showMessageSnackBar(
                                  context, "Invalid phone number");
                            } else if (!phoneController.text.startsWith('0')) {
                              showMessageSnackBar(
                                  context, "Number shoud begin with '0'");
                            } else {
                              showLoadingDialog(context);
                              String phoneNumber = formatPhoneNumber();

                              _verifyPhoneNumber(phoneNumber);
                            }
                          },
                          buttonText: 'Continue',
                          btnColor: AppColors.mainYellow,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatPhoneNumber() {
    // Remove any leading whitespace and trim the input
    String phoneNumber = phoneController.text.replaceAll('-', '').trim();
    phoneNumber = '+233${phoneNumber.substring(1)}';
    return phoneNumber;
  }

  void _verifyPhoneNumber(String poneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: poneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in with the credential.
        // await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle the failure.
        Navigator.pop(context);
        if (e.code == 'invalid-phone-number') {
          // Handle invalid phone number error
          showMessageSnackBar(context, "Invalid phone number");
        } else if (e.code == 'too-many-requests') {
          showMessageSnackBar(context,
              "Too many request, please try later or change phone number");
        } else {
          // Handle other verification failures
          //print('Verification failed with error code: ${e.code}');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPSignInScreen(
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          ),
        );

        await setAuthData(context);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // The SMS code was not retrieved automatically.
      },
    );
  }

  Future<void> setAuthData(BuildContext context) async {
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();
    SharePrefercesHlper prefHelper = SharePrefercesHlper();
    String phone = formatPhoneNumber();
    prefHelper.setUserSignInData(phone);
    authData.setPhoneNumber(phone);
    // authData.setOTPCode(returned);

    print(authData.name);
    print(authData.phoneNumber);
    print(authData.otpCode);
  }

  //<---------GOOGLE SIGNUP METHODS START GOOGLE SIGNUP METHODS START--------------->

  Future<String> googleSignUp(BuildContext context) async {
    final AuthService auth = context.read<AuthService>();
    final FirestoreService firestoreService = context.read<FirestoreService>();
    final UserExistCheckerService existCheckerService =
        context.read<UserExistCheckerService>();

    currentGoogleUser = await auth.signinWithGoogle();

    if (currentGoogleUser != null) {
      //Checking the User-Auth-Method-Status
      // ignore: use_build_context_synchronously
      String authMethodReturned = await existCheckerService
          .checkGoogleAuthUserExists(context, currentGoogleUser!.email);

      print("Printing $authMethodReturned");

      if (authMethodReturned == 'NewUser') {
        //Getting Google-Crendentials
        final GoogleSignInAuthentication googleSignInAuthentication =
            await currentGoogleUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        //Authenticaing User-Credential with FirebaseAuth
        Navigator.pop(context);
        String authStatus = await auth.signInWithCredential(credential);

        if (authStatus == 'Success') {
          await firestoreService.saveGoogleAuthUserData(
            auth.getCurrentUser()!.uid,
            currentGoogleUser!.displayName!,
            currentGoogleUser!.email,
            currentGoogleUser!.photoUrl!,
          );
        }

        return authStatus;
      } else if (authMethodReturned == 'EmailAuthUsed') {
        return 'EmailAuthUsed';
      } else if (authMethodReturned == 'phoneAuthWasUsed') {
        return 'phoneAuthWasUsed';
      } else if (authMethodReturned == 'Registered-Driver') {
        return 'Registered-Driver';
      } else if (authMethodReturned == 'GoogleAuthUsed-Completed') {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await currentGoogleUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        //Authenticaing User-Credential with FirebaseAuth
        String authStatus = await auth.signInWithCredential(credential);
        Navigator.pop(context);

        return authStatus;
      }
    }

    Navigator.pop(context);

    return 'Failed';
  }
}
