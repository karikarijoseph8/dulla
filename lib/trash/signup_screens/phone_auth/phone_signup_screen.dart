import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/buttons/auth_social_btn.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/textfields/authTextField.dart';
import 'package:orbit/screens/authentication/phone_auth/phone_auth_screen.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:provider/provider.dart';
import '../../../../components/app_alerts_dialogs.dart';
import '../../../../components/customfont/customFonts.dart';
import '../../../../constants/app_colors.dart';
import '../../../../routes.dart';
import 'otp_signin_screen.dart';

class PhoneSignupScreen extends StatefulWidget {
  const PhoneSignupScreen({super.key});

  @override
  State<PhoneSignupScreen> createState() => _PhoneSignupScreenState();
}

class _PhoneSignupScreenState extends State<PhoneSignupScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  bool isTermsAccepted = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //final OrbitCustomAuth orbitCustomAuth = context.read<OrbitCustomAuth>();
    return Scaffold(
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
                        onPressed: () async {
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
                        buttonText: 'Sign up',
                        btnColor: AppColors.mainYellow,
                      ),
                    ),

                    SizedBox(
                      height: 62,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Divider(
                            thickness: 1, // Set the thickness of the divider
                            color: Color(
                                0xFFEEEEEE), //Set the color of the divider
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "or continue with",
                          style: GoogleFonts.urbanist(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Divider(
                            thickness: 1, // Set the thickness of the divider
                            color: Color(
                                0xFFEEEEEE), // Set the color of the divider
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),

                    SizedBox(
                      height: 28,
                    ),

                    //Auth Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: AuthSocialButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/icons/facebook.png",
                              width: 21,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: AuthSocialButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/icons/google.png",
                              width: 21,
                            ),
                          ),
                        ),
                        AuthSocialButton(
                          onPressed: () {
                            print("pressed");
                            Navigator.pushNamed(context, '/emailSignUp');
                          },
                          child: Image.asset(
                            "assets/icons/email.png",
                            width: 21,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 54,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.urbanist(
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              SlideUpRoute(
                                builder: (_) => const PhoneAuthScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.urbanist(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mainYellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatPhoneNumber() {
    // Remove any leading whitespace and trim the input
    String phoneNumber = phoneController.text.replaceAll(' ', '').trim();
    phoneNumber = '+233${phoneNumber.substring(1)}';
    return phoneNumber;
  }

  void _verifyPhoneNumber(String poneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: poneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in with the credential.
        await auth.signInWithCredential(credential);
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

        print('Verification failed with error code: ${e.code}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.of(context).push(SlideUpRoute(
            builder: (_) => OTPSignUpScreen(
                  verificationId: verificationId,
                  resendToken: resendToken,
                )));

        await setAuthData(context);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // The SMS code was not retrieved automatically.
      },
    );
  }

  Future<void> setAuthData(BuildContext context) async {
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();
    String phone = formatPhoneNumber();
    authData.setPhoneNumber(phone);
    // authData.setOTPCode(returned);
  }
}
