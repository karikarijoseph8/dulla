import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/textfields/otpTextField.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/routes.dart';
import 'package:orbit/screens/authentication/phone_auth/accout_setup_phoneauth_screen.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/trash/twilio_servce.dart';
import 'package:provider/provider.dart';
import 'package:truncate/truncate.dart';
import '../../../../components/app_alerts_dialogs.dart';

class OTPSignInScreen extends StatefulWidget {
  const OTPSignInScreen({
    super.key,
    required this.verificationId,
    this.resendToken,
  });
  final String verificationId;
  final int? resendToken;

  @override
  State<OTPSignInScreen> createState() => _OTPSignInScreenState();
}

class _OTPSignInScreenState extends State<OTPSignInScreen> {
  TextEditingController _controller1 = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _seconds = 30;
  bool _countingDown = true;

  final _focusNode1 = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    _controller1.addListener(_onTextChanged);

    startCountdown();

    _focusNode1.addListener(() {
      print("Has focus: ${_focusNode1.hasFocus}");
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();

    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();

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
                    otpTextField(
                      controller: _controller1,
                    ),
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
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      showAlertDialog(context, "Error signing up", returned);
                    } else {
                      //showLoadingDialog(context);
                      bool userExit = await _checkIfEmailExist();
                      if (userExit == true) {
                        // final fetching = await fetchUserData(context);
                        Navigator.pop(context);

                        Navigator.popUntil(
                            context, (_) => !Navigator.canPop(context));
                        // if (fetching == 'done') {
                        //   await Future.delayed(const Duration(seconds: 2));
                        //   Navigator.pop(context);
                      } else {
                        //Navigator.pop(context);
                        Navigator.of(context).pushReplacement(SlideUpRoute(
                          builder: (_) => const AccountSetupPhoneAuth(
                            inCompleteSignup: false,
                          ),
                        ));
                      }
                    }

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

                            Navigator.pop(context);
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

  Future<bool> _checkIfEmailExist() async {
    final AuthService auth = context.read<AuthService>();
    String uid = auth.getCurrentUser()!.uid;

    return _firestore
        .collection('userData')
        .doc(uid)
        //.where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    });
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
    String userEnteredCode = _controller1.text.trim();

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
