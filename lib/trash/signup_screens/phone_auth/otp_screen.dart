import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/textfields/otpTextField.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/trash/orbit_auth_provider.dart';
import 'package:orbit/trash/twilio_servce.dart';
import 'package:provider/provider.dart';
import 'package:truncate/truncate.dart';
import '../../../../components/app_alerts_dialogs.dart';

import 'package:uuid/uuid.dart';

class OTPScreenPhoneAuth extends StatefulWidget {
  const OTPScreenPhoneAuth({
    super.key,
    required this.verificationId,
    this.resendToken,
  });
  final String verificationId;
  final int? resendToken;

  @override
  State<OTPScreenPhoneAuth> createState() => _OTPScreenPhoneAuthState();
}

class _OTPScreenPhoneAuthState extends State<OTPScreenPhoneAuth> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  int _seconds = 30;
  bool _countingDown = true;

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();

  @override
  void initState() {
    _controller1.addListener(_onTextChanged);
    _controller2.addListener(_onTextChanged);
    _controller3.addListener(_onTextChanged);
    _controller4.addListener(_onTextChanged);
    startCountdown();

    _focusNode1.addListener(() {
      print("Has focus: ${_focusNode1.hasFocus}");
    });

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
    final authProvider = Provider.of<OrbitAuthProvider>(context);

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
                    // otpTextField(controller: _controller4, fieldNumber: 5),
                    // otpTextField(controller: _controller4, fieldNumber: 6),
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
                    // bool isVerified = verifyOTP(authData.otpCode!);
                    // print("Printing Bool");
                    // print(isVerified);
                    // if (isVerified == true) {
                    //   await authenticatePhoneAuthUser();
                    //   print(authProvider.currentUser!.phoneNumber);
                    // }
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AccountSetupEmailAuth()),
                    // );
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

  Future<void> authenticatePhoneAuthUser() async {
    final OrbitAuthProvider orbitCustomAuth = context.read<OrbitAuthProvider>();
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();
    print("authing custom User");

    await orbitCustomAuth.signInWithPhone(authData.phoneNumber!);

    // if (newUser != null) {
    //   print('User created with custom UID: ${newUser.uid}');
    // }
  }

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
