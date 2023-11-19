import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  int _selectedCardIndex = -1; // To keep track of the selected card index

  final List<String> cardHeaders = [
    'MoMo',
    'Google Pay',
    'Credit Card',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Payment Method",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "Select the top up method you want to use.",
              style: CustomFonts.urbanist(fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: cardHeaders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCardIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cardHeaders[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Radio(
                            activeColor: AppColors.mainYellow,
                            value: index,
                            groupValue: _selectedCardIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedCardIndex = value!;
                              });
                            },
                          ),

                          // CustomRadio(
                          //   value: index,
                          //   groupValue: _selectedCardIndex,
                          //   onChanged: (int? value) {
                          //     setState(() {
                          //       _selectedCardIndex = value!;
                          //     });
                          //   },
                          //   selectedColor:
                          //       Colors.blue, // Change to your desired color
                          //   unselectedColor:
                          //       Colors.grey, // Change to your desired color
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: SubmitButton(
                onPressed: () {},
                buttonText: 'Continue',
                btnColor: AppColors.mainYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadio extends Radio<int> {
  final Color selectedColor;
  final Color unselectedColor;

  CustomRadio({
    required int value,
    required int groupValue,
    required ValueChanged<int?> onChanged,
    required this.selectedColor,
    required this.unselectedColor,
  }) : super(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: selectedColor,
          // Here we use the selectedColor as the activeColor
        );

  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: AppColors.mainYellow,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(
        child: Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
