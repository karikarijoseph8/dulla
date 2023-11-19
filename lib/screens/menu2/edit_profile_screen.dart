import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/textfields/authTextField.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/entities/user_entity.dart';
import '../../models/entities/wallet_entity.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.userEntity});

  final UserHive userEntity;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String getFirstWord(String text) {
    List<String> words = text.split(" ");
    if (words.isNotEmpty) {
      return words[0];
    } else {
      return "";
    }
  }

  String getSecondWord(String text) {
    List<String> words = text.split(" ");
    if (words.isNotEmpty) {
      return words[1];
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // final editProfileAurguments =
    // ModalRoute.of(context)!.settings.arguments as EditProfileAurguments;
    // firstNameController.text = editProfileAurguments.userEntity.full_name;
    firstNameController.text = getFirstWord(widget.userEntity.full_name);
    lastNameController.text = getSecondWord(widget.userEntity.full_name);
    phoneController.text = widget.userEntity.phone;
    emailController.text = widget.userEntity.email;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: AuthTextFormField(
                            enabled: false,
                            controller: phoneController,
                            hint: 'Phone',
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
                            enabled: false,
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
                              // if (!isEmail(val)) {
                              //   return 'Invalid email';
                              // }
                              // return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: 290,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SubmitButton(
                            onPressed: () {
                              //createWallet();
                              //addTransactionToWallet();
                              //addMyBooking();

                              // addPolicy();
                              // addPolicy2();
                              // addPolicy3();
                              // addPolicy4();

                              AddAddress(widget.userEntity.user_ID);
                              AddAddress2(widget.userEntity.user_ID);
                            },
                            buttonText: 'Update',
                            btnColor: AppColors.mainYellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> AddAddress(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final helpCenterRef = firestore.collection('userData').doc(uid);
    final addressRef = helpCenterRef.collection('address').doc();
    try {
      await addressRef.set({
        'addressName': "Work",
        'addressDetail': 'Hohoe, Volta Region, Ghana',
        'addressID': addressRef.id,
        'addressLatitude': -634.634,
        'addressLongitutde': 934.3434,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> AddAddress2(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final helpCenterRef = firestore.collection('userData').doc(uid);
    final addressRef = helpCenterRef.collection('address').doc();
    try {
      await addressRef.set({
        'addressName': "Market",
        'addressDetail': 'Zamu, Volta Region, Ghana',
        'addressID': addressRef.id,
        'addressLatitude': -634.634,
        'addressLongitutde': 934.3434,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addPolicy() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final helpCenterRef = firestore.collection('appData').doc("helpCenter");
    final privacyPolicyRef = helpCenterRef.collection('privacyPolicy').doc();
    try {
      await privacyPolicyRef.set({
        'policyHeader': "Data Collection",
        'policyBody':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
        'policyCode': 1,
        'policyID': privacyPolicyRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addPolicy2() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final helpCenterRef = firestore.collection('appData').doc("helpCenter");
    final privacyPolicyRef = helpCenterRef.collection('privacyPolicy').doc();
    try {
      await privacyPolicyRef.set({
        'policyHeader': "Data Usage",
        'policyBody':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
        'policyCode': 2,
        'policyID': privacyPolicyRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addPolicy3() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final helpCenterRef = firestore.collection('appData').doc("helpCenter");
    final privacyPolicyRef = helpCenterRef.collection('privacyPolicy').doc();
    try {
      await privacyPolicyRef.set({
        'policyHeader': "Data Sharing",
        'policyBody':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
        'policyCode': 3,
        'policyID': privacyPolicyRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addPolicy4() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final helpCenterRef = firestore.collection('appData').doc("helpCenter");
    final privacyPolicyRef = helpCenterRef.collection('privacyPolicy').doc();
    try {
      await privacyPolicyRef.set({
        'policyHeader': "Security",
        'policyBody':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
        'policyCode': 4,
        'policyID': privacyPolicyRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addChat() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef
        .collection('privacyPolicy')
        .doc()
        .collection('chatData')
        .doc();
    try {
      await faqRef.set({
        'message':
            "I am a Customer Service, is there anything I can help you with!",
        'senderID': 'wpxVNSoE0RcAKQcIluZXl7rBuuy',
        'messageID': faqRef.id,
        'timeStamp': DateTime.now(),
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addContactUs() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('contactUs').doc();
    try {
      await faqRef.set({
        'contactHandle': "WhatsApp",
        'contactType': "whatsapp",
        'contactID': faqRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addContactUs2() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('contactUs').doc();
    try {
      await faqRef.set({
        'contactHandle': "Instagram",
        'contactType': "intagram",
        'contactID': faqRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addContactUs3() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('contactUs').doc();
    try {
      await faqRef.set({
        'contactHandle': "Twitter",
        'contactType': "twitter",
        'contactID': faqRef.id,
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addTransactionToWallet() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final walletRef =
          firestore.collection('wallets').doc("wpxVNSoE0RcAKQcIluZXl7rBuPp2");
      final transactionRef =
          walletRef.collection('transactionHistory').doc("ORB3423893436878");

      await transactionRef.set({
        'transactionID': "ORB3423893436878",
        'timestamp': DateTime.now(),
        'description': "Transaction description",
        'transactionNameDriverName': 'Wallet Top Up',
        'driverImg':
            'https://firebasestorage.googleapis.com/v0/b/orbit-devbox-2398e.appspot.com/o/reindolf.jpg?alt=media&token=eec4dc52-da2a-4de9-861a-9427fe0d9f2f',
        //'transactionType': 'Taxi Expense',
        'transactionType': 'Top Up',
        //'discount': 6.3,
        //'discountedAmount': 13.5,
        'originalAmount': 23.3,
        'status': 'successful',
        //'paymentMethod': 'My E-Wallet',
        //'driverCarName': 'Mercedes-Benz',
        // 'driverNumberPlate': 'AS 8654-23',
        //'driverRating': 4.5
      });
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<void> addMyBooking() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final walletRef =
          firestore.collection('userData').doc("wpxVNSoE0RcAKQcIluZXl7rBuPp2");
      final myBookingsRef = walletRef.collection('myBookings').doc();

      await myBookingsRef.set({
        //driver
        'mybookingID': myBookingsRef.id,
        'driverName': 'Reindolf Sarpong',
        'driverImg':
            'https://firebasestorage.googleapis.com/v0/b/orbit-devbox-2398e.appspot.com/o/reindolf.jpg?alt=media&token=eec4dc52-da2a-4de9-861a-9427fe0d9f2f',
        'driverCarName': "Mercedes-Benz",
        'driverPlateNumber': "AS 8654-23",
        //trip 5
        'distance': 23.45,
        'time': 12,
        'tripFare': 12.3,
        'tripStatus': 'completed',
        'timeStamp': DateTime.now(),
        //pickUp
        'pictLocationName': 'Central Park',
        'pictLocationAddress': '123 Central Park West, New York, NY',
        "pictLocationLatitude": 40.785091,
        "pictLocationLongitube": -73.968285,
        //destinatin
        "destinationName": "Times Square",
        "destinationAddress": "123 Times Square Ave, New York, NY",
        "destinationLatitube": 40.758896,
        "destinationLongitube": -73.985130
      });

      //
      //       //trip
      //       distance: data['distance'],
      //       time: data['time'],
      //       tripFare: data['tripFare'],
      //       tripStatus: data['tripStatus'],
      //       timeStamp: data['timeStamp'],
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<void> createWallet() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('wallets')
          .doc("wpxVNSoE0RcAKQcIluZXl7rBuPp2")
          .set({
        'userId': "wpxVNSoE0RcAKQcIluZXl7rBuPp2",
        'balance': 0.0,
        'walletID': '2333 23233 2323 889 999'
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addFaq() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('faqs').doc();
    try {
      await faqRef.set({
        'faqQuestion': "Is there a minimum age requirement to use the app?",
        'faqAnswer':
            "The minimum age requirement varies by region and service. In most cases, you must be at least 18 years old to use the app. Please check our terms and conditions for specific age requirements in your area.",
        'faqType': 'Account',
        'faqID': faqRef.id
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addFaq2() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('faqs').doc();
    try {
      await faqRef.set({
        'faqQuestion': "Can I use my social media accounts to sign up?",
        'faqAnswer':
            "Yes, many taxi-hailing apps offer the option to sign up using your social media accounts like Facebook or Google. It can simplify the registration process.",
        'faqType': 'Account',
        'faqID': faqRef.id
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addFaq3() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('faqs').doc();
    try {
      await faqRef.set({
        'faqQuestion': "How do I create an account on the app?",
        'faqAnswer':
            "To create an account, download the app, open it, and click on the Sign Up or Register button. Follow the on-screen instructions, which typically include providing your name, email address, phone number, and creating a password.",
        'faqType': 'Account',
        'faqID': faqRef.id
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addFaq4() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('faqs').doc();
    try {
      await faqRef.set({
        'faqQuestion': "What information is required during registration?",
        'faqAnswer':
            "During registration, we typically require your name, email address, phone number, and a password. This information helps us create and verify your account.",
        'faqType': 'Account',
        'faqID': faqRef.id
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> addFaq5() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef.collection('faqs').doc();
    try {
      await faqRef.set({
        'faqQuestion': "How do I reset my password if I forget it?",
        'faqAnswer':
            "You can reset your password by selecting the Forgot Password or Reset Password option on the login screen. We will send you instructions to reset your password via email or SMS.",
        'faqType': 'Account',
        'faqID': faqRef.id
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }
}
