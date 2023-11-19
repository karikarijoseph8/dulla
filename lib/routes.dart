import 'package:flutter/material.dart';
import 'package:orbit/screens/home/call_screen.dart';
import 'package:orbit/screens/home/driver_deteils_screen.dart';
import 'package:orbit/screens/menu2/address/add_address_screen.dart';
import 'package:orbit/screens/menu2/address/address_screen.dart';
import 'package:orbit/screens/menu2/help_center/customer_care_screen.dart';
import 'package:orbit/screens/menu2/help_center/help_center_screen.dart';
import 'package:orbit/screens/menu2/mybooks/mybooking_screen.dart';
import 'package:orbit/screens/menu2/notification.dart';
import 'package:orbit/screens/menu2/paymen_method_screen.dart';
import 'package:orbit/screens/menu2/privacy_policy_screen.dart';
import 'package:orbit/screens/menu2/wallet/my_wallet_screen.dart';
import 'package:orbit/screens/menu2/wallet/paymen_method_screen.dart';
import 'package:orbit/screens/menu2/wallet/receipt_screen.dart';
import 'package:orbit/screens/menu2/wallet/topup_wallet_screen.dart';
import 'package:orbit/screens/menu2/wallet/transaction_history_screen.dart';
import 'package:orbit/trash/signup_screens/email_auth/email_signup_screen.dart';
import 'package:orbit/trash/signup_screens/email_auth/otp_screen.dart';
import 'trash/signup_screens/phone_auth/phone_signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  //AUTHENTICATION ROUTES START
  '/emailSignUp': (BuildContext context) => const EmailSignupScreen(),

  '/phoneSignUp': (BuildContext context) => const PhoneSignupScreen(),
  '/otpScreenEmailSignUp': (BuildContext context) =>
      const OTPScreenEmailSignUp(),
  // '/otpScreenPhoneAuth': (BuildContext context) => const OTPScreenPhoneAuth(),
  //AUTHENTICATION ROUTES END

  //MENU ROUTES START
  //'/menu': (BuildContext context) => const Menu(),
  '/menuHelpCenter': (BuildContext context) => const HelpCenterScreen(),
  '/notificationScreen': (BuildContext context) => const NotificationScreen(),
  '/menuHelpCenterCustomerCare': (BuildContext context) => CustomerCareScreen(),
  '/menuPrivacyPolicy': (BuildContext context) => PrivacyPolicyScreen(),
  //'/menuEditProfile': (BuildContext context) => EditProfileScreen(),
  '/menuMyWallet': (BuildContext context) => MyWalletScreen(),
  '/menuMyWalletTransactionHistory': (BuildContext context) =>
      TransactionHistoryScreen(),
  '/menuMyWalletEReceipt': (BuildContext context) => EReceiptScreen(),
  '/menuMyWalletTopUp': (BuildContext context) => TopUpWalletScreen(),
  '/menuPaymentMethod': (BuildContext context) => PaymentMethodScreen(),
  '/menuSelectPaymentMethod': (BuildContext context) =>
      SelectPaymentMethodScreen(),
  '/menuMyBooking': (BuildContext context) => MyBookingScreen(),
  '/menuAddress': (BuildContext context) => AddressScreen(),
  '/menuAddAddress': (BuildContext context) => AddNewAddress(),

  //MENU ROUTES END

  //HOME ROUTES START
  // '/homeTripCancellationScreen': (BuildContext context) =>
  //     TripCancellationScreen(),
  '/homeCallScreen': (BuildContext context) => const CallScreen(),
  '/homeDriverDetailScreen': (BuildContext context) => DriverDetailsScreen(),
  //'/homescreen': (BuildContext context) => const HomeScreen(),
  //HOME ROUTES END
};

final Map<String, PageRouteBuilder> customRoutes = {
  // //MENU ROUTES START
  //'/menu': (BuildContext context) => const Menu(),
  '/menuHelpCenter': SlidePageRoute(builder: (_) => const HelpCenterScreen()),
  '/notificationScreen':
      SlidePageRoute(builder: (_) => const NotificationScreen()),
  '/menuHelpCenterCustomerCare':
      SlidePageRoute(builder: (_) => CustomerCareScreen()),
  '/menuPrivacyPolicy': SlidePageRoute(builder: (_) => PrivacyPolicyScreen()),
  //'/menuEditProfile': (BuildContext context) => EditProfileScreen(),
  '/menuMyWallet': SlidePageRoute(builder: (_) => MyWalletScreen()),
  '/menuMyWalletTransactionHistory':
      SlidePageRoute(builder: (_) => TransactionHistoryScreen()),
  '/menuMyWalletEReceipt': SlidePageRoute(builder: (_) => EReceiptScreen()),
  '/menuMyWalletTopUp': SlidePageRoute(builder: (_) => TopUpWalletScreen()),
  '/menuPaymentMethod': SlidePageRoute(builder: (_) => PaymentMethodScreen()),
  '/menuSelectPaymentMethod':
      SlidePageRoute(builder: (_) => SelectPaymentMethodScreen()),
  '/menuMyBooking': SlidePageRoute(builder: (_) => MyBookingScreen()),
  '/menuAddress': SlidePageRoute(builder: (_) => AddressScreen()),

  '/menuAddAddress': SlidePageRoute(builder: (_) => AddNewAddress())
  //MENU ROUTES END

  //HOME ROUTES START
  // '/homeTripCancellationScreen': (BuildContext context) =>
  //     TripCancellationScreen(),
  // '/homeCallScreen': (BuildContext context) => const CallScreen(),
  // '/homeDriverDetailScreen': (BuildContext context) => DriverDetailsScreen(),
  // '/homescreen': (BuildContext context) => const HomeScreen(),
  //HOME ROUTES END
};

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  SlidePageRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin =
                Offset(1.0, 0.0); // Start the animation from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}

class SlideUpRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  SlideUpRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin =
                Offset(0.0, 1.0); // Start the animation from the bottom
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}
