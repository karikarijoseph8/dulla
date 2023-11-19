//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/customfont/customFonts.dart';

import '../../components/textfields/authTextField.dart';
// import 'package:provider/provider.dart';
// import 'package:validators/validators.dart';

// import '../../components/snackbar_alert_loading.dart';
// import '../../components/submit_button.dart';
// import '../../components/textfields/authTextField.dart';
// import '../../components/textfields/auth_text_formfield.dart';
// import '../../services/providers/auth_service.dart';
// import '../../services/providers/firestore_service.dart';
// import '../../services/providers/registration_auth_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isTermsAccepted = false;

  // For password
  late bool _passwordVisible;

  // For Re-enter Password
  late bool _passwordVisible2;

  bool _isContinueButtonActive = false;

  // void _isAllFormFieldsNotEmptyAndTermsAccepted() {
  //   if (nameController.text != null &&
  //       emailController.text != null &&
  //       phoneController.text != null &&
  //       passwordController.text != null &&
  //       cpasswordController.text != null &&
  //       isTermsAccepted) {
  //     setState(() {
  //       _isContinueButtonActive = true;
  //     });
  //   } else {
  //     setState(() {
  //       _isContinueButtonActive = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // CustomProgressDialog dialogBackground = CustomProgressDialog(
    //   context,
    //   blur: 10,
    // );
    // dialogBackground.setLoadingWidget(
    //   NutsActivityIndicator(
    //     activeColor: Theme.of(context).appBarTheme.titleTextStyle!.color!,
    //     radius: 25,
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Hype Investors',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Center(
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Signup to start a session',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: nameController,
                        hint: 'Full Name',
                        validator: (val) => val!.length > 30
                            ? 'More than 30 characters'
                            : val.length < 2
                                ? 'Too short'
                                : null,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: emailController,
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
                          if (!isEmail(val)) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: phoneController,
                        hint: 'Phone Number',
                        validator: (val) =>
                            val!.length < 10 ? 'Not valid' : null,
                        keyboardType: TextInputType.phone,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: phoneController,
                        hint: '',
                        prefixText: '+233',
                        preffixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.person,
                              // ),
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                "assets/icons/gh.png",
                                width: 30,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xFFD9D9D9),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       '+233',
                              //       style: CustomFonts.regular(),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        validator: (val) =>
                            val!.length < 10 ? 'Not valid' : null,
                        keyboardType: TextInputType.phone,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: passwordController,
                        hint: 'Password',
                        validator: (val) => val!.length == 0
                            ? 'Password required'
                            : val.length < 6
                                ? 'Too short'
                                : null,
                        obscureText: !_passwordVisible,
                        preffixIcon: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            "assets/svgIcons/Lock.svg",
                            width: 10,
                            height: 5,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AuthTextFormField(
                        controller: cpasswordController,
                        hint: 'Re-enter password',
                        validator: (val) => val! != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                        obscureText: !_passwordVisible2,
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible2 = !_passwordVisible2;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isTermsAccepted,
                          checkColor: Theme.of(context).scaffoldBackgroundColor,
                          activeColor: Colors.greenAccent,
                          onChanged: (val) {
                            setState(() {
                              isTermsAccepted = val!;
                            });
                            //  _isAllFormFieldsNotEmptyAndTermsAccepted();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // setAuthData(context);
                              Navigator.pushNamed(context, '/terms');
                            }
                          },
                          child: Text(
                            'I ACCEPT TERMS AND CONDITIONS',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.yellowAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: SubmitButton(
                    //     onPressed: _isContinueButtonActive
                    //         ? () async {
                    //             if (isTermsAccepted) {
                    //               if (formKey.currentState != null &&
                    //                   formKey.currentState!.validate()) {
                    //                 setAuthData(context);
                    //                 showLoadingDialog(context);
                    //                 String returned = await signUp(context);
                    //                 Navigator.pop(context);
                    //                 if (returned != 'Success') {
                    //                   showAlertDialog(context,
                    //                       "Error signing up", returned);
                    //                 } else {
                    //                   saveUserProfileToFirestore(context);

                    //                   saveEmptyWatchlist(context);
                    //                   Navigator.popUntil(context,
                    //                       (_) => !Navigator.canPop(context));
                    //                   Navigator.pushReplacementNamed(
                    //                       context, '/verifyemail');
                    //                 }
                    //               }
                    //             } else {
                    //               showMessageSnackBar(context,
                    //                   "Please review and accept terms and conditions");
                    //             }
                    //           }
                    //         : null,
                    //     buttonText: 'Signup',
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmail(String email) {
    // Regular expression to match email format
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regex pattern
    return emailRegex.hasMatch(email);
  }

  // void setAuthData(BuildContext context) {
  //   final RegistrationAuthData authData = context.read<RegistrationAuthData>();
  //   authData.setEmail(emailController.text.trim());
  //   authData.setPassword(passwordController.text);
  //   authData.setName(nameController.text);
  //   authData.setPhoneNumber(phoneController.text);
  // }

  // Future<void> saveUserProfileToFirestore(BuildContext context) async {
  //   final FirestoreService firestoreService = context.read<FirestoreService>();
  //   final AuthService auth = context.read<AuthService>();
  //   final RegistrationAuthData authData = context.read<RegistrationAuthData>();

  //   await firestoreService.saveProfileData(auth.getCurrentUser()!.uid,
  //       authData.name!, authData.email!, authData.phoneNumber!);
  //   await firestoreService.saveToTotalNumOfUser();
  // }

  // Future<String> signUp(BuildContext context) async {
  //   final AuthService auth = context.read<AuthService>();

  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //       emailController.text.trim(),
  //       passwordController.text,
  //       nameController.text,
  //       phoneController.text,
  //     );

  //     return 'Success';
  //   } on FirebaseAuthException catch (e) {
  //     return e.message.toString();
  //   } catch (e) {
  //     return 'Unknown Error';
  //   }
  // }

  // Future<void> saveEmptyWatchlist(BuildContext context) async {
  //   final FirestoreService firestoreService = context.read<FirestoreService>();
  //   final AuthService auth = context.read<AuthService>();

  //   await firestoreService.createStockWatchlist(auth.getCurrentUser()!.uid);
  //   await firestoreService.createHypeDataList(auth.getCurrentUser()!.uid);
  // }
}
