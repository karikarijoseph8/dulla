import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/trash/twilio_servce.dart';
import 'package:provider/provider.dart';
import 'package:truncate/truncate.dart';
import '../../../../components/app_alerts_dialogs.dart';
import '../../../../service/providers/auth_service.dart';
import '../../../../service/providers/firebase_service.dart';

import 'package:uuid/uuid.dart';

class OTPScreenEmailSignUp extends StatefulWidget {
  const OTPScreenEmailSignUp({super.key});

  @override
  State<OTPScreenEmailSignUp> createState() => _OTPScreenEmailSignUpState();
}

class _OTPScreenEmailSignUpState extends State<OTPScreenEmailSignUp> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  int _seconds = 30;
  bool _countingDown = true;

  @override
  void initState() {
    _controller1.addListener(_onTextChanged);
    _controller2.addListener(_onTextChanged);
    _controller3.addListener(_onTextChanged);
    _controller4.addListener(_onTextChanged);
    startCountdown();

    // _focusNode1.addListener(() {
    //   print("Has focus: ${_focusNode1.hasFocus}");
    // });

    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Confirm your",
                style: GoogleFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Number",
                style: GoogleFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Enter the code sent you on ${truncate('${authData.phoneNumber}', 6, omission: "***", position: TruncatePosition.start)}",
                style: CustomFonts.urbanist(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // otpTextField(controller: _controller1, fieldNumber: 1),
                    // otpTextField(controller: _controller2, fieldNumber: 2),
                    // otpTextField(controller: _controller3, fieldNumber: 3),
                    // otpTextField(controller: _controller4, fieldNumber: 4),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: SubmitButton(
                  onPressed: () async {
                    bool isVerified = verifyOTP(authData.otpCode!);

                    if (isVerified == true) {
                      updateEmailAuthUserWithPhone();
                      Navigator.pushReplacementNamed(context, '/homescreen');
                    }
                  },
                  buttonText: 'Continue',
                  btnColor: AppColors.mainYellow,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _countingDown
                      ? Text(
                          "Resend code in ",
                          style: CustomFonts.urbanist(color: Color(0xFF9E9E9E)),
                        )
                      : Container(),
                  GestureDetector(
                    onTap: _countingDown
                        ? null
                        : () async {
                            showLoadingDialog(context);
                            String returned = await sendOTPSMS(
                                context, authData.phoneNumber!);
                            Navigator.pop(context);

                            if (returned != 'SMS-FAILED') {
                              showMessageSnackBar(
                                  context, "Orbit OTP Code Sent");
                            } else {
                              print(returned);
                            }
                          },
                    child: Text(
                      _countingDown ? '$_seconds' : 'Resend',
                      style: CustomFonts.urbanist(
                        color: AppColors.mainYellow,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _countingDown
                      ? Text(
                          "s",
                          style: CustomFonts.urbanist(color: Color(0xFF9E9E9E)),
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool verifyOTP(String generatedCode) {
    String digit1 = _controller1.text;
    String digit2 = _controller2.text;
    String digit3 = _controller3.text;
    String digit4 = _controller4.text;

    // Concatenate the digits to form the user-entered code
    String userEnteredCode = digit1 + digit2 + digit3 + digit4;
    // Compare the user-entered code with the generated code
    return userEnteredCode == generatedCode;
  }

  Future<void> updateEmailAuthUserWithPhone() async {
    final FirestoreService firestoreService = context.read<FirestoreService>();
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();
    final AuthService auth = context.read<AuthService>();
    await firestoreService.updateEmailAuthUserDataWithPhone(
        auth.getCurrentUser()!.uid, authData.phoneNumber!, authData.name!);
  }

  Future<String> sendOTPSMS(BuildContext context, String to) async {
    final TwilioService twilioService = context.read<TwilioService>();
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();

    String returned = await twilioService.sendTwilioSMS(to);
    authData.setOTPCode(returned);

    print(returned);
    return returned;
  }

  String generateCustomVerificationId() {
    final uuid = Uuid();
    return uuid.v4(); // Generate a random UUID
  }

  // Future<void> linkPhoneAuthWithEmail() async {
  //   //FirebaseAuth auth = FirebaseAuth.instance;
  //   //User? user = auth.currentUser;

  //   //user.

  //   try {
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '',
  //       verificationCompleted: (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {
  //         if (e.message == '') {}
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         // Navigator.pushNamed(
  //         //   context,
  //         //   PhoneOTP.routeName,
  //         //   arguments: PhoneAuthArguments(
  //         //       verificationId: verificationId,
  //         //       phone: phone,
  //         //       email: emailController.text.trim(),
  //         //       indexNumber: indexNumberController.text,
  //         //       name: nameController.text,
  //         //       password: passwordController.text),
  //         // );
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //     //final userCredential =
  //     //auth.signInWithCustomToken('Abc12DfGhIjKlMnOpQrStUvWxYz0123456789');
  //     //Create a PhoneAuthCredential using verificationId and smsCode
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: generateCustomVerificationId(),
  //       smsCode: '345455',
  //     );

  //     // Sign in the user with the credential
  //     // UserCredential userCredential =
  //     // await FirebaseAuth.instance.signInWithCredential(credential);
  //     // userCredential.additionalUserInfo.
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'custom-token-mismatch') {
  //       // The custom token didn't match the user's current credentials
  //     } else if (e.code == 'credential-already-in-use') {
  //       print(e.code);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//RESEND COUNTDOWN
  void startCountdown() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_seconds == 0) {
        setState(() {
          _countingDown = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }
}
