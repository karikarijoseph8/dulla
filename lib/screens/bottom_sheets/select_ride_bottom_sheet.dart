import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:truncate/truncate.dart';

import '../../models/trip/address.dart';
import '../../service/providers/trip/route_provider.dart';

class SelectRideBottomSheet extends StatelessWidget {
  const SelectRideBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: 300,
      minHeight: 300,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(18.0),
        topLeft: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .5,
      panelSnapping: true,
      backdropEnabled: true,
      boxShadow: const [
        BoxShadow(
          spreadRadius: 6,
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        )
      ],
      body: Container(),
      panelBuilder: (controller) => SelectRidePanelWidget(
        controller: controller,
      ),
    );
  }
}

class SelectRidePanelWidget extends StatelessWidget {
  const SelectRidePanelWidget({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    Padding(padding: EdgeInsets.zero);
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select a ride",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),

          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 9),
            decoration: BoxDecoration(
              color: Color(0xFFFFFCF2),
              border: Border.all(
                color: AppColors.mainYellow, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(10.0), // Border radius
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/yellow_car_export.png",
                      width: 72,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Elite",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text("5 min",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Color(0xFF747682),
                                  //fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgIcons/profile_icon.svg",
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("4",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Color(0xFF747682),
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Best save",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.mainYellow,
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  "GH 33",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 9),
                // decoration: BoxDecoration(
                //   //color: Color(0xFFFFFCF2),
                //   border: Border.all(
                //     color: AppColors.mainYellow, // Border color
                //     width: 1.0, // Border width
                //   ),
                //   borderRadius: BorderRadius.circular(10.0), // Border radius
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/yellow_car_export.png",
                          width: 72,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Elite",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text("5 min",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Color(0xFF747682),
                                      //fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(
                                  width: 8,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgIcons/profile_icon.svg",
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("4",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Color(0xFF747682),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "GH 43",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 298,
                child: Divider(
                  thickness: 1, // Set the thickness of the divider
                  color: Color(0xFFEEEEEE), //Set the color of the divider
                ),
              ),
            ],
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Flexible(
          //       child: Divider(
          //         thickness: 1, // Set the thickness of the divider
          //         color: Color(0xFFEEEEEE), //Set the color of the divider
          //       ),
          //     ),
          //   ],
          // ),

          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   height: 50,
          //   child: SubmitButton(
          //     onPressed: () {},
          //     buttonText: 'Continue to Order',
          //     btnColor: AppColors.mainYellow,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PickUpDestinationCard extends StatelessWidget {
  const PickUpDestinationCard({
    super.key,
    required this.routeDataProvider,
  });

  final RouteDataProvider routeDataProvider;

  @override
  Widget build(BuildContext context) {
    var pickup = routeDataProvider.pickUpLocation;

    var destination = routeDataProvider.dropOffLocation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              "assets/svgIcons/booking_pickup4.svg",
              width: 45,
            ),
            // SvgPicture.asset(
            //   "assets/svgIcons/booking_destination.svg",
            //   width: 45,
            // ),
          ],
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConfirmOrderTile(
                address: pickup,
                onPress: () {},
              ),
              SizedBox(
                height: 24,
              ),
              ConfirmOrderTile(
                address: destination,
                onPress: () {},
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           truncate(
              //               routeDataProvider.dropOffLocation.placeName, 30,
              //               omission: "..."),
              //           style: CustomFonts.urbanist(
              //             fontWeight: FontWeight.w700,
              //             fontSize: 17,
              //           ),
              //         ),
              //         SizedBox(
              //           height: 4,
              //         ),
              //         Text(
              //           truncate(
              //               routeDataProvider
              //                   .dropOffLocation.placeFormattedAddress,
              //               40,
              //               omission: "..."),
              //           style: CustomFonts.urbanist(
              //             color: AppColors.greyMessages2,
              //             fontSize: 13,
              //           ),
              //         ),
              //       ],
              //     ),
              //     // SizedBox(
              //     //   width: 40,
              //     // ),
              //     SvgPicture.asset(
              //       "assets/svgIcons/confirmtrip_order_edit.svg",
              //       width: 16,
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class ConfirmOrderTile extends StatelessWidget {
  const ConfirmOrderTile({
    super.key,
    required this.address,
    required this.onPress,
  });

  final Address address;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    String mainPickUp = getFirstPartBeforeComma(address.placeName);
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  truncate(mainPickUp, 30, omission: "..."),
                  style: CustomFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  truncate(address.placeFormattedAddress, 40, omission: "..."),
                  style: CustomFonts.urbanist(
                    color: AppColors.greyMessages2,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/svgIcons/confirmtrip_order_edit.svg",
              width: 16,
            )
          ],
        ),
      ),
    );
  }

  String getFirstPartBeforeComma(String input) {
    // Split the input string by the comma
    List<String> parts = input.split(',');

    // Check if there is at least one part before the comma
    if (parts.isNotEmpty) {
      // Return the first part (trimmed to remove leading/trailing spaces)
      return parts.first.trim();
    } else {
      // Return an empty string if there are no parts before the comma
      return '';
    }
  }
}

class DriverDetailCard extends StatelessWidget {
  const DriverDetailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(
        top: 14,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius:
                    26, // Adjust this value to change the size of the circular profile picture
                backgroundImage: AssetImage(
                    'assets/images/babe.jpg'), // Replace this with your image asset path
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Divas Elk",
                      style: CustomFonts.urbanist(
                          color: AppColors.mainBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Mercedes-Benz",
                        style: CustomFonts.urbanist(
                            color: AppColors.greyMessages2, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgIcons/rating.svg",
                    width: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "4.8",
                    style: CustomFonts.urbanist(
                      color: AppColors.greyMessages2,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "AS 8654-23",
                style: CustomFonts.urbanist(
                  color: AppColors.mainBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
