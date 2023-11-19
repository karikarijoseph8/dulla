import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/entities/wallet_entity.dart';
import '../../screens/menu2/wallet/receipt_screen.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.walletTransaction,
  });

  final WalletTransaction walletTransaction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/menuMyWalletEReceipt',
          arguments: ReceiptArg(walletTransaction: walletTransaction
              // Replace with your actual UserEntity instance
              ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius:
                //       26, // Adjust this value to change the size of the circular profile picture
                //   backgroundImage: NetworkImage(walletTransaction
                //       .img), // Replace this with your image asset path
                // ),

                if (walletTransaction.transactionType == "Top Up") ...[
                  SvgPicture.asset(
                    "assets/svgIcons/topup_icon.svg",
                    width: 53,
                  ),
                ] else ...[
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
                  )
                ],

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
                      Row(
                        children: [
                          Text(formatDatestamp(walletTransaction.timestamp),
                              style: CustomFonts.urbanist(
                                  color: AppColors.greyMessages2,
                                  fontSize: 13)),
                          Text(
                              " | ${formatTimestamp(walletTransaction.timestamp)}",
                              style: CustomFonts.urbanist(
                                  color: AppColors.greyMessages2,
                                  fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (walletTransaction.transactionType == "Top Up") ...[
                  Text(
                    "GHS ${walletTransaction.originalAmount}",
                    style: CustomFonts.urbanist(
                        color: AppColors.mainBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ] else ...[
                  Text(
                    "GHS ${walletTransaction.discountedAmount.toString()}",
                    style: CustomFonts.urbanist(
                        color: AppColors.mainBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      walletTransaction.transactionType,
                      style: CustomFonts.urbanist(
                          color: AppColors.greyMessages2, fontSize: 13),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (walletTransaction.transactionType == "Top Up") ...[
                      SvgPicture.asset(
                        "assets/svgIcons/topedup.svg",
                        width: 14,
                      )
                    ] else ...[
                      SvgPicture.asset(
                        "assets/svgIcons/taxi_expense.svg",
                        width: 14,
                      )
                    ],
                  ],
                ),
              ],
            )
          ],
        ),
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
