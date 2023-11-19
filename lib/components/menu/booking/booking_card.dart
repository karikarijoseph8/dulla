import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

import '../../../models/entities/booking_entity.dart';

class BookingCard extends StatefulWidget {
  BookingCard({
    required this.myBooking,
  });

  final BookingEntity myBooking;

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool _isBodyVisible = false;

  void _toggleBodyVisibility() {
    setState(() {
      _isBodyVisible = !_isBodyVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _toggleBodyVisibility,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.09),
                      offset: Offset(0, 3),
                      blurRadius: 8,
                    )
                  ]),
              //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              padding: EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 22,
                  bottom: _isBodyVisible ? 8 : 18),
              child: Column(
                children: [
                  Row(
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
                                  widget.myBooking.driverName,
                                  style: CustomFonts.urbanist(
                                      color: AppColors.mainBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.myBooking.driverCarName,
                                  style: CustomFonts.urbanist(
                                      color: AppColors.greyMessages2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (widget.myBooking.tripStatus == "Cancelled") ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.mainRed,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.myBooking.tripStatus,
                                style: CustomFonts.urbanist(
                                  color: AppColors.mainWhite,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ] else if (widget.myBooking.tripStatus ==
                              "Completed") ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.mainGreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.myBooking.tripStatus,
                                style: CustomFonts.urbanist(
                                  color: AppColors.mainWhite,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ] else ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.mainYellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.myBooking.tripStatus,
                                style: CustomFonts.urbanist(
                                  color: AppColors.mainWhite,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.myBooking.driverPlateNumber,
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
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Divider(
                          thickness: 1, // Set the thickness of the divider
                          color:
                              Color(0xFFEEEEEE), //Set the color of the divider
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isBodyVisible)
            Container(
              //padding: EdgeInsets.all(16),
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgIcons/booking_distance.svg",
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.myBooking.distance} km",
                            style: CustomFonts.urbanist(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgIcons/booking_duration.svg",
                            width: 21,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.myBooking.time} mins",
                            style: CustomFonts.urbanist(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgIcons/booking_amount.svg",
                            width: 21,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "GHS ${widget.myBooking.tripFare}",
                            style: CustomFonts.urbanist(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date and Time",
                        style: CustomFonts.urbanist(
                            color: AppColors.greyMessages2, fontSize: 14),
                      ),
                      Text(
                        "${formatDatestamp(widget.myBooking.timeStamp)} | ${formatTimestamp(widget.myBooking.timeStamp)}",
                        style:
                            CustomFonts.urbanist(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Divider(
                          thickness: 1, // Set the thickness of the divider
                          color:
                              Color(0xFFEEEEEE), //Set the color of the divider
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svgIcons/booking_pickup3.svg",
                            width: 45,
                          ),
                          // SvgPicture.asset(
                          //   "assets/svgIcons/booking_destination.svg",
                          //   width: 45,
                          // ),
                        ],
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.myBooking.pictLocationName,
                                style: CustomFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.myBooking.pictLocationAddress,
                                style: CustomFonts.urbanist(
                                  color: AppColors.greyMessages2,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.myBooking.destinationName,
                                style: CustomFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.myBooking.destinationAddress,
                                style: CustomFonts.urbanist(
                                  color: AppColors.greyMessages2,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          GestureDetector(
            onTap: _toggleBodyVisibility,
            child: Container(
              //padding: EdgeInsets.all(16),
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),

              child: Column(
                children: [
                  Icon(
                    _isBodyVisible
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: AppColors.mainYellow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDatestamp(DateTime dateTime) {
    final formattedDate = DateFormat.MMMd().format(dateTime);
    final year = dateTime.year;

    return '$formattedDate, $year';
  }

  String formatTimestamp(DateTime dateTime) {
    final formattedTime = DateFormat.jm().format(dateTime);

    return formattedTime;
  }
}
