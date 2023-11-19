import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/buttons/round_btn.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchingForDriver extends StatefulWidget {
  const SearchingForDriver({
    super.key,
    required this.cancelDriverSearch,
  });

  final VoidCallback cancelDriverSearch;

  @override
  State<SearchingForDriver> createState() => _SearchingForDriver();
}

class _SearchingForDriver extends State<SearchingForDriver> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: 270,
      //minHeight: 410,
      minHeight: 270,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(18.0),
        topLeft: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .5,
      panelSnapping: true,
      backdropEnabled: false,
      boxShadow: const [
        BoxShadow(
          spreadRadius: 6,
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        )
      ],
      body: Container(),
      panelBuilder: (controller) => SearchingForDriverPanelWidget(
        controller: controller,
        onPressed: widget.cancelDriverSearch,
      ),
    );
  }
}

class SearchingForDriverPanelWidget extends StatefulWidget {
  const SearchingForDriverPanelWidget(
      {super.key, required this.controller, required this.onPressed});

  final ScrollController controller;

  final VoidCallback onPressed;

  @override
  State<SearchingForDriverPanelWidget> createState() =>
      _SearchingForDriverPanelWidgetState();
}

class _SearchingForDriverPanelWidgetState
    extends State<SearchingForDriverPanelWidget> {
  int _secondsRemaining = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _secondsRemaining = 30; // Reset the countdown to 30 seconds
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Looking For Nearby Driver",
                style: CustomFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainBlack,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          Text(
            "There are several cars, we are looking at which, one will fit best",
            style: CustomFonts.poppins(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "00: $_secondsRemaining",
            style: CustomFonts.poppins(fontSize: 14),
          ),

          SizedBox(
            height: 12,
          ),
          LinearProgressIndicator(
            value: 1 - (_secondsRemaining / 30), // Calculate the progress value
            minHeight: 5,
            backgroundColor: Color(0xFFDFE2E5),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.mainYellow),
          ),

          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: SubmitButton(
              onPressed: widget.onPressed,
              buttonText: 'CANCEL',
              btnColor: AppColors.mainYellow,
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.43,
          //       height: 50,
          //       child: SubmitButton(
          //         onPressed: () {},
          //         buttonText: 'No Thanks',
          //         btnColor: AppColors.lightYellow,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.43,
          //       height: 50,
          //       child: SubmitButton(
          //         onPressed: () {},
          //         buttonText: 'Pay Tips',
          //         btnColor: AppColors.mainYellow,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class SelectableCardsGrid extends StatefulWidget {
  @override
  _SelectableCardsGridState createState() => _SelectableCardsGridState();
}

class _SelectableCardsGridState extends State<SelectableCardsGrid> {
  int _selectedCardIndex = 0;

  void _handleCardTap(int cardIndex) {
    setState(() {
      if (_selectedCardIndex == cardIndex) {
        // If the same card is tapped again, deselect it
        _selectedCardIndex = -1;
      } else {
        // Select the card corresponding to the given index
        _selectedCardIndex = cardIndex;
      }
    });
  }

  List<String> helpCategory = [
    "2",
    "4",
    "6",
    "8",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(helpCategory.length, (index) {
          return SelectableCard(
            text: helpCategory[index], // Use your own text
            isSelected: _selectedCardIndex == index,
            onTap: () => _handleCardTap(index),
          );
        }),
      ),
    );
  }
}

class SelectableCard extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  SelectableCard({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.mainYellow : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.mainYellow, // Border color
            width: 2, // Border width
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svgIcons/cedi2.svg",
              width: 15,
              color: widget.isSelected
                  ? AppColors.mainBlack
                  : AppColors.mainYellow,
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: widget.isSelected
                    ? AppColors.mainBlack
                    : AppColors.mainYellow,
              ),
            ),
          ],
        ),
      ),
    );
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
                      "Reindolf Sarpong",
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
