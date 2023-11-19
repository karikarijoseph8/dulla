import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/menu/transaction_card.dart';
import 'package:orbit/constants/app_colors.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.mainBlack, // Change this to your desired color
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Transaction history",
            style: CustomFonts.urbanist(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.mainBlack,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              // children: [
              //   SizedBox(
              //     height: 10,
              //   ),
              //   TransactionCard(
              //     img: CircleAvatar(
              //       radius:
              //           26, // Adjust this value to change the size of the circular profile picture
              //       backgroundImage: AssetImage(
              //           'assets/images/babe.jpg'), // Replace this with your image asset path
              //     ),
              //     name: 'Divas Elk',
              //     transactionIcon: 'assets/svgIcons/taxi_expense.svg',
              //     transactionType: 'Taxi Expense',
              //     date: 'Feb 0, 20232',
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/menuMyWalletEReceipt');
              //     },
              //   ),
              //   TransactionCard(
              //     img: SvgPicture.asset(
              //       "assets/svgIcons/topup_icon.svg",
              //       width: 53,
              //     ),
              //     name: 'Top Up Wallet',
              //     transactionIcon: 'assets/svgIcons/topedup.svg',
              //     transactionType: 'Top Up',
              //     date: 'Feb 0, 20232',
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/menuMyWalletEReceipt');
              //     },
              //   ),
              //   TransactionCard(
              //     img: CircleAvatar(
              //       radius:
              //           26, // Adjust this value to change the size of the circular profile picture
              //       backgroundImage: AssetImage(
              //           'assets/images/babe.jpg'), // Replace this with your image asset path
              //     ),
              //     name: 'Divas Elk',
              //     transactionIcon: 'assets/svgIcons/taxi_expense.svg',
              //     transactionType: 'Taxi Expense',
              //     date: 'Feb 0, 20232',
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/menuMyWalletEReceipt');
              //     },
              //   ),
              //   TransactionCard(
              //     img: SvgPicture.asset(
              //       "assets/svgIcons/topup_icon.svg",
              //       width: 53,
              //     ),
              //     name: 'Top Up Wallet',
              //     transactionIcon: 'assets/svgIcons/topedup.svg',
              //     transactionType: 'Top Up',
              //     date: 'Feb 0, 20232',
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/menuMyWalletEReceipt');
              //     },
              //   ),
              //   TransactionCard(
              //     img: CircleAvatar(
              //       radius:
              //           26, // Adjust this value to change the size of the circular profile picture
              //       backgroundImage: AssetImage(
              //           'assets/images/babe.jpg'), // Replace this with your image asset path
              //     ),
              //     name: 'Divas Elk',
              //     transactionIcon: 'assets/svgIcons/taxi_expense.svg',
              //     transactionType: 'Taxi Expense',
              //     date: 'Feb 0, 20232',
              //     onPressed: () {},
              //   ),
              //   TransactionCard(
              //     img: SvgPicture.asset(
              //       "assets/svgIcons/topup_icon.svg",
              //       width: 53,
              //     ),
              //     name: 'Top Up Wallet',
              //     transactionIcon: 'assets/svgIcons/topedup.svg',
              //     transactionType: 'Top Up',
              //     date: 'Feb 0, 20232',
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/menuMyWalletEReceipt');
              //     },
              //   )
            ],
          ),
        ));
  }
}
