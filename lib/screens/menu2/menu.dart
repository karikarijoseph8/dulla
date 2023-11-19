import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/routes.dart';
import 'package:orbit/screens/menu2/address/add_address_screen.dart';
import 'package:orbit/screens/menu2/address/address_screen.dart';
import 'package:orbit/screens/menu2/wallet/my_wallet_screen.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/service/streams/stream_preloader.dart';
import 'package:orbit/service/streams/stream_provider.dart';
import 'package:provider/provider.dart';
import '../../components/app_alerts_dialogs.dart';
import '../../components/shimmer/shimmer.dart';
import '../../models/entities/user_entity.dart';
import 'edit_profile_screen.dart';

class Menu extends StatefulWidget {
  Menu({super.key, required this.userEntity});

  final UserHive userEntity;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    final StreamPreloader streamPreloader = StreamPreloader();
    final AuthService auth = context.read<AuthService>();

    streamPreloader.preloadUserData('wpxVNSoE0RcAKQcIluZXl7rBuPp2');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
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
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 28,
              ),
              ProfileHeader(
                userEntity: widget.userEntity,
              ),
              SizedBox(
                height: 12,
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
                      color: Color(0xFFEEEEEE), //Set the color of the divider
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              ProfileMenuTile(
                title: 'Edit Profile',
                leftIconPath: 'assets/svgIcons/Profile.svg',
                leftIconSize: 16,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        userEntity: widget.userEntity,
                      ),
                    ),
                  );
                },
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/locationMap.svg',
                title: 'My Wallet',
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    '/menuMyWallet',
                    arguments: WalletArg(
                      userEntity: widget
                          .userEntity, // Replace with your actual UserEntity instance
                    ),
                  );
                  // Navigator.pushNamed(context, '/menuEditProfile');
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/payment-method.svg',
                title: 'Payment Method',
                onPress: () {
                  Navigator.pushNamed(context, '/menuPaymentMethod');
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/locationMap.svg',
                title: 'Address',
                onPress: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   '/menuAddress',
                  //   arguments: WalletArg(
                  //     userEntity: widget
                  //         .userEntity, // Replace with your actual UserEntity instance
                  //   ),
                  // );

                  Navigator.of(context)
                      .push(SlidePageRoute(builder: (_) => AddressScreen()));
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/trip-history.svg',
                title: 'My Bookings',
                onPress: () {
                  Navigator.pushNamed(context, '/menuMyBooking');
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/notification.svg',
                title: 'Notifcation',
                onPress: () {
                  Navigator.pushNamed(context, '/notificationScreen');
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/refer2.svg',
                title: 'Invite a Friend',
                onPress: () {},
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/privacy-policy.svg',
                title: 'Privacy Policy',
                onPress: () {
                  Navigator.pushNamed(context, '/menuPrivacyPolicy');
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/trip-history3.svg',
                title: 'Help Center',
                onPress: () => Navigator.pushNamed(context, '/menuHelpCenter'),
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/rate.svg',
                title: 'Rate Us',
                onPress: () {},
                leftIconSize: 16,
                leftIconColor: AppColors.mainBlack,
              ),
              ProfileMenuTile(
                leftIconPath: 'assets/svgIcons/Logout.svg',
                title: 'Logout',
                onPress: () {
                  _showBottomSheet(context);
                },
                leftIconSize: 16,
                leftIconColor: AppColors.mainRed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.userEntity,
  });

  final UserHive userEntity;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    final StreamPreloader streamPreloader = StreamPreloader();
    return

        // Column(
        //   children: [
        //     Center(
        //       child: Stack(children: [
        //         CircleAvatar(
        //           radius:
        //               53, // Adjust this value to change the size of the circular profile picture
        //           backgroundImage: AssetImage(
        //               'assets/images/babe.jpg'), // Replace this with your image asset path
        //         ),
        //         Positioned(
        //           bottom: 0,
        //           right: 0,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(
        //                 5,
        //               ), // Adjust the radius as needed
        //               color: AppColors
        //                   .mainYellow, // Change this color to your desired background color
        //             ),
        //             padding: EdgeInsets.all(3),
        //             child: Icon(
        //               Icons.edit,
        //               color: Colors.white,
        //               size: 15,
        //             ),
        //           ),
        //         ),
        //       ]),
        //     ),
        //     SizedBox(
        //       height: 12,
        //     ),
        //     Text(
        //       "Joseph Karikari",
        //       style: CustomFonts.urbanist(
        //         fontSize: 20,
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 3,
        //     ),
        //     Text(
        //       "+233595371771",
        //       style: CustomFonts.urbanist(
        //         fontSize: 13,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ],
        // );

        StreamBuilder<UserEntity>(
            stream: db.getUserData(userEntity.user_ID),
            builder: (BuildContext context, snapshot) {
              final userData = snapshot.data;
              if (snapshot.hasData) {
                final userData = snapshot.data;
                print(userData!.blocked);

                return Column(
                  children: [
                    Center(
                      child: Stack(children: [
                        CircleAvatar(
                          radius:
                              53, // Adjust this value to change the size of the circular profile picture
                          backgroundImage: AssetImage(
                              'assets/images/babe.jpg'), // Replace this with your image asset path
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5,
                              ), // Adjust the radius as needed
                              color: AppColors
                                  .mainYellow, // Change this color to your desired background color
                            ),
                            padding: EdgeInsets.all(3),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      userData.full_name,
                      style: CustomFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      userData.phone,
                      style: CustomFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Container(
                    child: Text("Error While ${snapshot.error}"),
                  ),
                );
              }

              return Column(
                children: [
                  CircleShimmer(
                    size: 110,
                  ),

                  SizedBox(
                    height: 12,
                  ),

                  Shimmer(
                    height: 20,
                    width: 150,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Shimmer(
                    height: 15,
                    width: 90,
                  ),
                  //Container(),
                ],
              );
            });
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 210,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.greyLogout,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              "Logout",
              style: CustomFonts.urbanist(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainRed),
            ),
            SizedBox(
              height: 10,
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
                    color: Color(0xFFEEEEEE), //Set the color of the divider
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: SubmitButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    buttonText: 'Cancel',
                    btnColor: AppColors.lightYellow,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: SubmitButton(
                    onPressed: () async {
                      showLoadingDialog(context);
                      await logUserOut(context).then((value) =>
                          Navigator.popUntil(
                              context, (_) => !Navigator.canPop(context)));
                    },
                    buttonText: 'Yes, logout',
                    btnColor: AppColors.mainYellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> logUserOut(BuildContext context) async {
  final AuthService authService = context.read<AuthService>();
  await authService.logoutUser();
}

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.leftIconPath,
    required this.leftIconSize,
    required this.onPress,
    required this.leftIconColor,
  });

  final String title;
  final String leftIconPath;
  final Color leftIconColor;
  final double leftIconSize;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPress,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    leftIconPath,
                    width: leftIconSize,
                    color: leftIconColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: CustomFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: leftIconColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xFFB7B9BA),
              )
            ],
          ),
        ),
      ),
    );
  }
}
