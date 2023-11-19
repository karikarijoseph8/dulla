import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/global_contants.dart';
import 'package:orbit/service/providers/firebase_service.dart';
import 'package:provider/provider.dart';
import '../../../../components/app_alerts_dialogs.dart';
import '../../../../components/textfields/authTextField.dart';
import '../../../../service/providers/auth_service.dart';

class AccountSetupPhoneAuth extends StatefulWidget {
  const AccountSetupPhoneAuth({super.key, required this.inCompleteSignup});

  final bool inCompleteSignup;

  @override
  State<AccountSetupPhoneAuth> createState() => _AccountSetupPhoneAuthState();
}

class _AccountSetupPhoneAuthState extends State<AccountSetupPhoneAuth> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Setup your",
                style: CustomFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Account",
                style: CustomFonts.urbanist(
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
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: firstNameController,
                        hint: 'First Name',
                        validator: (val) => val!.length > 30
                            ? 'More than 30 characters'
                            : val.length < 2
                                ? 'Too short'
                                : null,
                        textCapitalization: TextCapitalization.words,
                        style: CustomFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: lastNameController,
                        hint: 'Last Name',
                        validator: (val) => val!.length > 30
                            ? 'More than 30 characters'
                            : val.length < 2
                                ? 'Too short'
                                : null,
                        textCapitalization: TextCapitalization.words,
                        style: CustomFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: emailController,
                        focusNode: _focusNode,
                        style: CustomFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        preffixIcon: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            "assets/svgIcons/Message.svg",
                            width: 10,
                            height: 5,
                          ),
                        ),
                        hint: 'Email Address',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Empty';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
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
                          showLoadingDialog(context);

                          bool emailExist = await _checkIfEmailExist(
                              emailController.text.trim());

                          if (emailExist == true) {
                            Navigator.pop(context);
                            showErrorDialog(context, "Email Already Used",
                                "Sorry, your email has been used already. Kindly change the email");
                          } else {
                            Navigator.pop(context);
                            bool isSaved =
                                await saveUserProfileToFirestore(context);

                            if (isSaved == true) {
                              print("It's Saved");
                              // HomeWrapper();

                              if (widget.inCompleteSignup == false) {
                                Navigator.popUntil(
                                    context, (_) => !Navigator.canPop(context));
                              }
                            } else {}
                          }
                        },
                        buttonText: 'Complete Signup',
                        btnColor: AppColors.mainYellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //void

  String concatenateNames(String firstName, String lastName) {
    return '$firstName $lastName';
  }

  // Future<void> saveUserProfileToFirestore(BuildContext context) async {
  //   final FirestoreService firestoreService = context.read<FirestoreService>();
  //   final AuthService auth = context.read<AuthService>();
  //   final RegistrationAuthData authData = context.read<RegistrationAuthData>();

  //   await firestoreService.savePhoneAuthUserData(
  //     auth.currentUser.id,
  //     authData.phoneNumber!,
  //     emailController.text.trim(),
  //     concatenateNames(
  //       firstNameController.text.trim(),
  //       lastNameController.text.trim(),
  //     ),
  //   );
  //   //await firestoreService.saveToTotalNumOfUser();
  // }

  Future<bool> _checkIfEmailExist(String email) async {
    return _firestore
        .collection('userData')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> saveUserProfileToFirestore(BuildContext context) async {
    final FirestoreService firestoreService = context.read<FirestoreService>();
    final AuthService auth = context.read<AuthService>();
    final phone = sharedPref.getString("PHONE");

    try {
      await firestoreService.savePhoneAuthUserData(
        auth.getCurrentUser()!.uid,
        phone.toString(),
        emailController.text.trim(),
        concatenateNames(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
        ),
      );
      // Uncomment the following line if you want to save to total number of users
      // await firestoreService.saveToTotalNumOfUser();
      return true;
    } catch (e) {
      // Handle the exception here, you can print an error message or log it.
      print('Error while saving user profile to Firestore: $e');
      // You can also show a snackbar or display an error message to the user.
      // Example: Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      return false;
    }
  }
}
