import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/menu/menutile.dart';
import 'package:orbit/screens/menu/address/address-page.dart';
import 'package:orbit/screens/menu/notification/notification-page.dart';
import 'package:orbit/screens/menu/payment-method/paymentmethod-page.dart';
import 'package:orbit/screens/menu/profile/profile-page.dart';
import 'package:orbit/screens/menu/rateus/rateus-page.dart';
import 'package:orbit/screens/menu/referal/referal-page.dart';
import 'package:orbit/screens/menu/trip-history/triphistory-page.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.ctxt,
  });

  final BuildContext ctxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Color(0xFFAAACAE),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Account Settings",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 60,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: InkWell(
                    // splashColor: ,
                    onDoubleTap: () {
                      Navigator.pop(ctxt);
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Color(0xFF6A6D79),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/Profile.svg',
            title: 'Profile information',
            subTitle: 'Change your account information',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            leftIconSize: 16,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/trip-history3.svg',
            title: 'Trip history',
            subTitle: 'View your trip history',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripHistoryPage()),
              );
            },
            leftIconSize: 16,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/payment-method.svg',
            title: 'Payment method',
            subTitle: 'Set a payment method',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethodPage()),
              );
            },
            leftIconSize: 16,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/locationMap.svg',
            title: 'Address',
            subTitle: 'Add your locations',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressPage()),
              );
            },
            leftIconSize: 16,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/notification.svg',
            title: 'Notifcation',
            subTitle: 'Manage notifications',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            leftIconSize: 16,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/refer2.svg',
            title: 'Refer a friend',
            subTitle: 'Invite your friend',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReferalPage()),
              );
            },
            leftIconSize: 16,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                "More",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/rate.svg',
            title: 'Rate Us',
            subTitle: 'Rate our in App Store',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RateUsPage()),
              );
            },
            leftIconSize: 16,
          ),
          MenuTile(
            leftIconPath: 'assets/svgIcons/Logout.svg',
            title: 'Logout',
            subTitle: 'Logout of you account',
            onPress: () {},
            leftIconSize: 16,
          ),
        ],
      ),
    );
  }
}
