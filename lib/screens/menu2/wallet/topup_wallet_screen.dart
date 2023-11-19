import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class TopUpWalletScreen extends StatefulWidget {
  const TopUpWalletScreen({super.key});

  @override
  State<TopUpWalletScreen> createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final Random random = Random();

  @override
  void initState() {
    //_textEditingController.addListener(_formatCurrency);
    super.initState();
  }

  void _formatCurrency() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    String text = _textEditingController.text.replaceAll(',', '');
    if (text.isNotEmpty) {
      double value = double.parse(text);
      String formattedValue = formatter.format(value);
      _textEditingController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  Widget _buildButton(VoidCallback onPressed, String amount) {
    return SizedBox(
      height: 34,
      width: 100,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          side: BorderSide(
              width: 2.0, color: AppColors.mainYellow), // Add the outline here
        ),
        child: Text(
          '\GHS$amount',
          style: CustomFonts.urbanist(
            color: AppColors.mainYellow,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
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
          "Top Up E-Wallet",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.mainWhite,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter the amount to top up",
              style: CustomFonts.urbanist(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textEditingController,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.mainBlack,
              ), // Set the text style with a larger font size
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), // Set the input type to numbers only
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                LengthLimitingTextInputFormatter(4), // Only allow numbers
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.mainYellow, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),

                hintText: 'Amount',
                hintStyle: TextStyle(color: Colors.grey[300]),
                prefixIcon: _buildPrefixTextWidget(),
                // prefixStyle: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 20,
                //   color: Colors.blue, // Set prefix color based on focus
                //   //textAlign: TextAlign.center, // Center the prefix text
                // ),\

                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 29.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors
                        .mainYellow, // Border color when the TextField is focused
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildButton(() {}, "10"),
                      _buildButton(() {}, "20"),
                      _buildButton(() {}, "50"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildButton(() {}, "100"),
                      _buildButton(() {}, "200"),
                      _buildButton(() {}, "250"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildButton(() {}, "500"),
                      _buildButton(() {}, "750"),
                      _buildButton(() {}, "1000"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
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

  Widget _buildPrefixTextWidget() {
    return Container(
      alignment: Alignment.center,
      width: 30, // Adjust width as needed
      child: Text(
        'GH',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
