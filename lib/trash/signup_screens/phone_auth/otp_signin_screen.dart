import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/routes.dart';
import 'package:orbit/screens/authentication/phone_auth/accout_setup_phoneauth_screen.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/trash/orbit_auth_provider.dart';
import 'package:orbit/trash/twilio_servce.dart';
import 'package:provider/provider.dart';
import 'package:truncate/truncate.dart';
import '../../../../components/app_alerts_dialogs.dart';

class OTPSignUpScreen extends StatefulWidget {
  const OTPSignUpScreen({
    super.key,
    required this.verificationId,
    this.resendToken,
  });
  final String verificationId;
  final int? resendToken;

  @override
  State<OTPSignUpScreen> createState() => _OTPSignUpScreenState();
}

class _OTPSignUpScreenState extends State<OTPSignUpScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  int _seconds = 30;
  bool _countingDown = true;

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _controller1.addListener(_onTextChanged);
    _controller2.addListener(_onTextChanged);
    _controller3.addListener(_onTextChanged);
    _controller4.addListener(_onTextChanged);
    _controller5.addListener(_onTextChanged);
    _controller6.addListener(_onTextChanged);
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
    _controller5.dispose();
    _controller6.dispose();
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
                    // otpTextField(controller: _controller5, fieldNumber: 5),
                    // otpTextField(controller: _controller6, fieldNumber: 6),
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
                    showLoadingDialog(context);
                    String returned =
                        await authenticatePhoneAuthUser(widget.verificationId);

                    if (returned != 'Success') {
                      showAlertDialog(context, "Error signing up", returned);
                    } else {
                      bool numberExist =
                          await _checkIfNumberExist(authData.phoneNumber!);

                      if (numberExist == true) {
                        Navigator.popUntil(
                            context, (_) => !Navigator.canPop(context));
                      } else {
                        Navigator.of(context).pushReplacement(SlideUpRoute(
                          builder: (_) => AccountSetupPhoneAuth(
                            inCompleteSignup: false,
                          ),
                        ));

                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AccountSetupPhoneAuth()),
                        // );
                      }
                      //
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

  Future<bool> _checkIfNumberExist(String phoneNumber) async {
    return _firestore
        .collection('userData')
        .where('phone', isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
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

  Future<String> sendOTPSMS(BuildContext context, String to) async {
    final TwilioService twilioService = context.read<TwilioService>();
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();

    String returned = await twilioService.sendTwilioSMS(to);
    authData.setOTPCode(returned);

    print(returned);
    return returned;
  }

  Future<String> authenticatePhoneAuthUser(verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: getSMSCode(),
      );

      await auth.signInWithCredential(credential);

      // Authentication succeeded, you can add additional logic here.
      print('Authentication succeeded,');

      return 'Success';
    } catch (e) {
      // Handle authentication exceptions
      if (e is FirebaseAuthException) {
        // Firebase Authentication specific exceptions
        print('Firebase Authentication Error: ${e.code} - ${e.message}');
        // You can show user-friendly error messages or take appropriate actions.
        return 'e.code';
      } else {
        return 'Unkwon Error';
      }
    }
  }

  String getSMSCode() {
    String digit1 = _controller1.text;
    String digit2 = _controller2.text;
    String digit3 = _controller3.text;
    String digit4 = _controller4.text;
    String digit5 = _controller5.text;
    String digit6 = _controller6.text;
    String userEnteredCode =
        digit1 + digit2 + digit3 + digit4 + digit5 + digit6;
    // Concatenate the digits to form the user-entered code
    return userEnteredCode;
  }

  void startCountdown() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (!mounted) {
        // Check if the widget is still mounted before updating the state.
        timer.cancel(); // Cancel the timer to stop further updates.
        return;
      }

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
