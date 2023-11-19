import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:provider/provider.dart';

import '../../../models/entities/faq_entity.dart';
import '../../../service/providers/appdata_provider.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SelectableCardsGrid(),
          SizedBox(
            height: 20,
          ),

          Column(
            children: [
              FAQGenerator(),
            ],
          ),

          // HelpFAQCard(
          //   headerText: 'What is Orbit?',
          //   bodyText:
          //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate.',
          // ),
          // HelpFAQCard(
          //   headerText: 'How do I cancel ride book.',
          //   bodyText:
          //       'This is the body of the container. It will be hidden when the button is clicked.',
          // ),
          // HelpFAQCard(
          //   headerText: 'How to add promo code.',
          //   bodyText:
          //       'This is the body of the container. It will be hidden when the button is clicked.',
          // ),
          // HelpFAQCard(
          //   headerText: 'Is Orbit free to use',
          //   bodyText:
          //       'This is the body of the container. It will be hidden when the button is clicked.',
          // ),
        ],
      ),
    ));
  }
}

class FAQGenerator extends StatelessWidget {
  const FAQGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseFutures>(context, listen: false);
    final appDataProvider = Provider.of<AppDataProvider>(context);
    return FutureBuilder<List<FAQEntity>>(
      future: db.fetchFAQData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<FAQEntity> faqList = snapshot.data ?? [];

          // print("faqList");
          // print(faqList);
          print(appDataProvider.geSelectedFAQ);
          if (appDataProvider.geSelectedFAQ == 0) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "General",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else if (appDataProvider.geSelectedFAQ == 1) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Ride",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else if (appDataProvider.geSelectedFAQ == 2) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Account",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else if (appDataProvider.geSelectedFAQ == 3) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Payment",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else if (appDataProvider.geSelectedFAQ == 4) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Safety",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else if (appDataProvider.geSelectedFAQ == 5) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Driver Info",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else if (appDataProvider.geSelectedFAQ == 5) {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Feedback",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          } else {
            final generalFAQ = faqList
                .where(
                  (faq) => faq.faqType == "Technical Issues",
                )
                .toList();

            return Column(
                children: List.generate(generalFAQ.length, (index) {
              final faq = generalFAQ[index];
              return HelpFAQCard(
                faqEntity: faq,
              );
            }));
          }
          // return Column(
          //     children: List.generate(faqList.length, (index) {
          //   final faq = faqList[index];
          //   return HelpFAQCard(
          //     faqEntity: faq,
          //   );
          // }));
        }
      },
    );
  }
}

class SelectableCardsGrid extends StatefulWidget {
  @override
  _SelectableCardsGridState createState() => _SelectableCardsGridState();
}

class _SelectableCardsGridState extends State<SelectableCardsGrid> {
  int _selectedCardIndex = 0;

  void _handleCardTap(int cardIndex, AppDataProvider appDataProvider) {
    setState(() {
      // if (_selectedCardIndex == cardIndex) {
      //   // If the same card is tapped again, deselect it
      //   _selectedCardIndex = cardIndex;
      // } else {
      //   // Select the card corresponding to the given index
      //   _selectedCardIndex = cardIndex;
      // }

      _selectedCardIndex = cardIndex;
      appDataProvider.setSelectedFAQ = cardIndex;
    });
  }

  List<String> helpCategory = [
    "General",
    "Ride",
    "Account",
    "Payment",
    "Safety",
    "Drivers Info",
    "Feedback",
    "Technical Issues"
  ];

  @override
  Widget build(BuildContext context) {
    final appDataProvider = Provider.of<AppDataProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(helpCategory.length, (index) {
          return SelectableCard(
            text: helpCategory[index], // Use your own text
            isSelected: _selectedCardIndex == index,
            onTap: () => _handleCardTap(index, appDataProvider),
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
        padding: EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.mainYellow : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.mainYellow, // Border color
            width: 2, // Border width
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:
                widget.isSelected ? AppColors.mainBlack : AppColors.mainYellow,
          ),
        ),
      ),
    );
  }
}

class HelpFAQCard extends StatefulWidget {
  HelpFAQCard({required this.faqEntity});

  final FAQEntity faqEntity;

  @override
  _HelpFAQCardState createState() => _HelpFAQCardState();
}

class _HelpFAQCardState extends State<HelpFAQCard> {
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
                    bottomLeft: _isBodyVisible
                        ? Radius.circular(0)
                        : Radius.circular(10.0),
                    bottomRight: _isBodyVisible
                        ? Radius.circular(0)
                        : Radius.circular(10.0),
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
                  top: 18,
                  bottom: _isBodyVisible ? 8 : 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.faqEntity.faqQuestion,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
          if (_isBodyVisible)
            Container(
              //padding: EdgeInsets.all(16),
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              color: Colors.white,
              child: Column(
                children: [
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
                  Text(
                    widget.faqEntity.faqAnswer,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
