import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

import '../../../models/entities/wallet_entity.dart';

class EReceiptScreen extends StatefulWidget {
  const EReceiptScreen({super.key});

  @override
  State<EReceiptScreen> createState() => _EReceiptScreenState();
}

class _EReceiptScreenState extends State<EReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    final ReceiptArg receiptArg =
        ModalRoute.of(context)!.settings.arguments as ReceiptArg;
    WalletTransaction walletTransaction = receiptArg.walletTransaction;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "E-Receipt",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              BarCodeSection(
                walletTransaction: walletTransaction,
              ),
              SizedBox(
                height: 30,
              ),
              if (walletTransaction.transactionType == 'Taxi Expense') ...[
                DriverDetailCard(
                  walletTransaction: walletTransaction,
                ),
              ],
              SizedBox(
                height: 20,
              ),
              PriceCard(
                walletTransaction: walletTransaction,
              ),
              SizedBox(
                height: 20,
              ),
              PaymentMethodCard(
                walletTransaction: walletTransaction,
              ),
              SizedBox(
                height: 20,
              ),
              Categorycard(
                walletTransaction: walletTransaction,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Categorycard extends StatelessWidget {
  const Categorycard({
    super.key,
    required this.walletTransaction,
  });
  final WalletTransaction walletTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category",
                  style: CustomFonts.urbanist(
                    color: AppColors.greyMessages2,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  walletTransaction.transactionType,
                  style: CustomFonts.urbanist(
                      color: AppColors.mainBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.walletTransaction,
  });

  final WalletTransaction walletTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method",
                  style: CustomFonts.urbanist(
                    color: AppColors.greyMessages2,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  walletTransaction.paymentMethod,
                  style: CustomFonts.urbanist(
                      color: AppColors.mainBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date",
                style: CustomFonts.urbanist(
                  color: AppColors.greyMessages2,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${formatDatestamp(walletTransaction.timestamp)} | ${formatTimestamp(walletTransaction.timestamp)}",
                style: CustomFonts.urbanist(
                  color: AppColors.mainBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID",
                style: CustomFonts.urbanist(
                    color: AppColors.greyMessages2, fontSize: 13),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    walletTransaction.transactionID,
                    style: CustomFonts.urbanist(
                      color: AppColors.mainBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.copy_sharp,
                    color: AppColors.mainYellow,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: CustomFonts.urbanist(
                    color: AppColors.greyMessages2, fontSize: 13),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.mainYellow,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  walletTransaction.status,
                  style: CustomFonts.urbanist(
                    color: AppColors.mainBlack,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
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

class DriverDetailCard extends StatelessWidget {
  const DriverDetailCard({
    super.key,
    required this.walletTransaction,
  });
  final WalletTransaction walletTransaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  color: Colors.blue, // Set the background color
                  borderRadius: BorderRadius.circular(
                      75.0), // Set the border radius to make it round
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                        "assets/images/placeholer_wallettransaction.png"), // Replace with your custom placeholder widget
                    imageUrl: walletTransaction
                        .driverImg, // Replace with your image URL
                    width: 100, // Set the desired width
                    height: 100, // Set the desired height
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      walletTransaction.transactionNameDriverName,
                      style: CustomFonts.urbanist(
                          color: AppColors.mainBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      walletTransaction.driverCarName,
                      style: CustomFonts.urbanist(
                          color: AppColors.greyMessages2, fontSize: 14),
                    ),
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
                    "${walletTransaction.driverRating}",
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
                walletTransaction.driverNumberPlate,
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

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.walletTransaction,
  });

  final WalletTransaction walletTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Amount",
                  style: CustomFonts.urbanist(
                    color: AppColors.mainBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "GHS${walletTransaction.originalAmount}",
                  style: CustomFonts.urbanist(
                      color: AppColors.mainBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (walletTransaction.transactionType == "Taxi Expense") ...[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: CustomFonts.urbanist(
                    color: AppColors.mainYellow,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "-${walletTransaction.discount}",
                  style: CustomFonts.urbanist(
                    color: AppColors.mainYellow,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Divider(
                    thickness: 1, // Set the thickness of the divider
                    color: Color(0xFFEEEEEE), //Set the color of the divider
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style: CustomFonts.urbanist(
                        color: AppColors.greyMessages2, fontSize: 14)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${walletTransaction.discountedAmount}",
                  style: CustomFonts.urbanist(
                    color: AppColors.mainBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class BarCodeSection extends StatelessWidget {
  const BarCodeSection({
    super.key,
    required this.walletTransaction,
  });

  final WalletTransaction walletTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 280,
          height: 96,
          decoration: BoxDecoration(
            // color: Colors.black,
            image: const DecorationImage(
              image: AssetImage(
                "assets/images/barcode3.png",
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${removePrefixAndSeparateFirstID(walletTransaction.transactionID)}",
                style: CustomFonts.urbanist(fontSize: 12),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${removePrefixAndSeparateSecondID(walletTransaction.transactionID)}",
                style: CustomFonts.urbanist(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }

  String removePrefixAndSeparateFirstID(String inputString) {
    String prefix = 'ORB';
    // Check if the inputString starts with the given prefix
    if (inputString.startsWith(prefix)) {
      // Remove the prefix
      inputString = inputString.substring(prefix.length);

      // Calculate the length of the remaining string
      int length = inputString.length;

      // Calculate the index to split the string into two halves (rounded up)
      int halfLength = (length / 2).ceil();

      // Extract the first half of the remaining string
      String firstHalf = inputString.substring(0, halfLength);

      return firstHalf;
    } else {
      // If the prefix is not found, return the original string
      return inputString;
    }
  }

  String removePrefixAndSeparateSecondID(String input) {
    // Check if the input starts with "ORB" and has at least 7 characters.
    if (input.startsWith("ORB") && input.length >= 7) {
      // Remove the "ORB" prefix.
      String remainingDigits = input.substring(3);

      // Calculate the length of the second half of the remaining digits.
      int halfLength = (remainingDigits.length / 2).ceil();

      // Extract the second half of the remaining digits.
      String secondHalf = remainingDigits.substring(halfLength);

      return secondHalf;
    } else {
      // Return an error message or handle the invalid input as needed.
      return "Invalid input";
    }
  }
}

class ReceiptArg {
  final WalletTransaction walletTransaction;
  ReceiptArg({required this.walletTransaction});
}
