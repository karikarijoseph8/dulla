import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orbit/components/buttons/auth_social_btn.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/textfields/authTextField.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/service/providers/firebase_service.dart';
import 'package:provider/provider.dart';
import '../../../../components/app_alerts_dialogs.dart';
import '../../../../constants/app_colors.dart';
import '../../../../service/providers/userExist_checker_service.dart';
import '../phone_auth/phone_signup_screen.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GoogleSignInAccount? currentGoogleUser;

  // For password
  late bool _passwordVisible;
  bool isTermsAccepted = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Sign up with ",
                style: GoogleFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Your email",
                style: GoogleFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
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
                            color: Color(0xFF9E9E9E),
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

                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: SubmitButton(
                        onPressed: () async {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            setAuthData(context);
                            showLoadingDialog(context);
                            String returned =
                                await emailPasswordSignUp(context);
                            Navigator.pop(context);
                            if (returned != 'Success') {
                              showAlertDialog(
                                  context, "Error signing up", returned);
                              emailController.text = "";
                              passwordController.text = "";
                            } else {
                              saveUserProfileToFirestore(context);

                              Navigator.pushReplacementNamed(
                                  context, '/setupAccountEmailSignUp');
                            }
                          }
                        },
                        buttonText: 'Sign up',
                        btnColor: AppColors.mainYellow,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 40,
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
                            onPressed: () {
                              facebookSignUp(context);
                            },
                            child: Image.asset(
                              "assets/icons/facebook.png",
                              width: 21,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: AuthSocialButton(
                            onPressed: () async {
                              String returned = await googleSignUp(context);

                              print("This is returned");
                              print(returned);
                              Navigator.pop(context);

                              if (returned != 'Success') {
                                bool alertHasHeader = AlertHasHeader(returned);

                                if (alertHasHeader == true) {
                                  String header =
                                      extractAlertMessageHeader(returned);

                                  String body =
                                      extractAlertMessageBody(returned);
                                  showAlertDialog(context, header, body);
                                } else {
                                  showAlertDialog(
                                      context, "Error signing up", returned);
                                }

                                //print(header);
                              } else if (returned == 'IncompletedPhoneAuth') {
                                //saveUserProfileToFirestore(context);
                                // Navigator.pushReplacementNamed(
                                //     context, '/setupAccountEmailSignUp');

                                showAlertDialog(
                                    context, "Put Phone Auth Here", returned);
                              } else {
                                //saveUserProfileToFirestore(context);
                                Navigator.pushReplacementNamed(
                                    context, '/homescreen');
                              }
                            },
                            child: Image.asset(
                              "assets/icons/google.png",
                              width: 21,
                            ),
                          ),
                        ),
                        AuthSocialButton(
                          onPressed: () {
                            //Navigator.pushNamed(context, '/phoneSignUp');
                            Navigator.push(
                              context,
                              _createRoute(),
                            );
                          },
                          child: Image.asset(
                            "assets/icons/phone.png",
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
                          width: 10,
                        ),
                        Text(
                          "Sign in",
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainYellow,
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

  void setAuthData(BuildContext context) {
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();
    authData.setEmail(emailController.text.trim());
    authData.setPassword(passwordController.text);
    //authData.setName(nameController.text);
    // authData.setPhoneNumber(phoneController.text);
  }

  Future<String> emailPasswordSignUp(BuildContext context) async {
    final AuthService auth = context.read<AuthService>();
    try {
      await auth.createUserWithEmailAndPassword(
          emailController.text.trim(), passwordController.text);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unknown Error';
    }
  }

  //<---------GOOGLE SIGNUP METHODS START GOOGLE SIGNUP METHODS START--------------->

  //Alert Message Seperator
  String extractAlertMessageHeader(String inputText) {
    final parts = inputText.split(","); // Split the text by comma
    if (parts.length >= 1) {
      return parts[0]
          .trim(); // Get the first part (before the comma) and remove leading/trailing spaces
    } else {
      return ''; // Return an empty string if no comma is found
    }
  }

  bool AlertHasHeader(String inputText) {
    final parts = inputText.split(","); // Split the text by comma
    if (parts.length >= 2) {
      return true; //Get the first part (before the comma) and remove leading/trailing spaces
    } else {
      return false; //Return the full text with leading/trailing spaces
    }
  }

  String extractAlertMessageBody(String inputText) {
    final parts = inputText.split(","); // Split the text by comma
    if (parts.length >= 1) {
      return parts[1]
          .trim(); // Get the first part (before the comma) and remove leading/trailing spaces
    } else {
      return ''; // Return an empty string if no comma is found
    }
  }

  Future<String> googleSignUp(BuildContext context) async {
    final AuthService auth = context.read<AuthService>();
    final FirestoreService firestoreService = context.read<FirestoreService>();
    final UserExistCheckerService existCheckerService =
        context.read<UserExistCheckerService>();

    currentGoogleUser = await auth.signinWithGoogle();
    showLoadingDialog(context);
    if (currentGoogleUser != null) {
      //Checking the User-Auth-Method-Status
      String authMethodReturned = await existCheckerService
          .checkGoogleAuthUserExists(context, currentGoogleUser!.email);

      print("Printing authMethodReturned");
      print(authMethodReturned);

      if (authMethodReturned == 'NewUser') {
        //Getting Google-Crendentials
        final GoogleSignInAuthentication googleSignInAuthentication =
            await currentGoogleUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        //Authenticaing User-Credential with FirebaseAuth
        String authStatus = await auth.signInWithCredential(credential);

        if (authStatus == 'Success') {
          await firestoreService.saveGoogleAuthUserData(
            auth.getCurrentUser()!.uid,
            currentGoogleUser!.displayName!,
            currentGoogleUser!.email,
            currentGoogleUser!.photoUrl!,
          );
        }

        //Returning User-Auth-Status
        return authStatus;
      } else if (authMethodReturned == 'FacebookAuthWasUsed') {
        print("Different authMethodReturned");

        return 'Use Facebook to sign in,This account has already been registered with Facebook';
      } else if (authMethodReturned == 'EmailPasswordAuthWasUsed') {
        print("Different authMethodReturned");

        return 'Use Email & Password,This account has already been registered with email and password';

        //Navigator.pushReplacementNamed
      } else if (authMethodReturned == 'GoogleAuth-PhoneAuth-Not-Completed') {
        return 'IncompletedPhoneAuth';
      } else if (authMethodReturned == 'GoogleAuth-PhoneAuth-Was-Completed') {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await currentGoogleUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        //Authenticaing User-Credential with FirebaseAuth
        String authStatus = await auth.signInWithCredential(credential);

        return authStatus;
      }
    }

    return 'Failed';
  }

  //<---------GOOGLE SIGNUP METHODS END GOOGLE SIGNUP METHODS END--------------->

  Future<void> facebookSignUp(BuildContext context) async {
    final AuthService auth = context.read<AuthService>();

    final UserCredential userCredential = await auth.signInWithFacebook();

    print(userCredential.user!.displayName);
    print(userCredential.user!.email);
    print(userCredential.user!.photoURL);
    print(userCredential.user!.phoneNumber);
    print(userCredential.user!.emailVerified);
  }

  Future<void> saveUserProfileToFirestore(BuildContext context) async {
    final FirestoreService firestoreService = context.read<FirestoreService>();
    final AuthService auth = context.read<AuthService>();
    final RegistrationAuthData authData = context.read<RegistrationAuthData>();

    await firestoreService.saveEmailAuthUserData(
      auth.getCurrentUser()!.uid,
      authData.email!,
    );
    //await firestoreService.saveToTotalNumOfUser();
  }

  // Function to define the custom page transition animation
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PhoneSignupScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  bool isEmail(String email) {
    // Regular expression to match email format
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regex pattern
    return emailRegex.hasMatch(email);
  }
}
