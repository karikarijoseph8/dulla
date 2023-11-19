import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/menu/transaction_card.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/entities/user_entity.dart';
import 'package:orbit/models/entities/wallet_entity.dart';
import 'package:provider/provider.dart';
import '../../../components/buttons/topup_btn .dart';
import '../../../service/providers/auth_service.dart';
import '../../../service/streams/stream_provider.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    final WalletArg walletArg =
        ModalRoute.of(context)!.settings.arguments as WalletArg;

    print(walletArg.userEntity.full_name);

    //auth.getCurrentUser()!.uid
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.mainBlack, // Change this to your desired color
          ),
          backgroundColor: Colors.white,
          title: Text(
            "My Wallet",
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
          child: WalletPageBody(
            userEntity: walletArg.userEntity,
          ),
        ));
  }
}

class WalletPageBody extends StatelessWidget {
  const WalletPageBody({
    super.key,
    required this.userEntity,
  });

  final UserHive userEntity;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    return StreamBuilder<Wallet>(
        stream: db.getWalletData(auth.getCurrentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final walletData = snapshot.data;

            print(walletData);

            return Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 320,
                    height: 200,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 30, top: 20, bottom: 10, right: 20),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/wallet3.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainYellow.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userEntity.full_name,
                          style: CustomFonts.urbanist(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          walletData!.walletID,
                          style: CustomFonts.urbanist(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Your balance",
                          style: CustomFonts.urbanist(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "GHS",
                                  style: CustomFonts.urbanist(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Text(
                                  "${walletData.balance}",
                                  style: CustomFonts.urbanist(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height: 34,
                              child: TopUpButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/menuMyWalletTopUp');
                                },
                                buttonText: 'Top Up',
                                btnColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/menuMyWalletTransactionHistory');
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transaction History",
                            style: CustomFonts.urbanist(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainBlack),
                          ),
                          Text(
                            "See All",
                            style: CustomFonts.urbanist(
                                color: AppColors.mainYellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TransactionCardGenerator(),
                  // TransactionCard(
                  //   img: CircleAvatar(
                  //     radius:
                  //         26, // Adjust this value to change the size of the circular profile picture
                  //     backgroundImage: AssetImage(
                  //         'assets/images/babe.jpg'), // Replace this with your image asset path
                  //   ),
                  //   name: 'Divas Elk',
                  //   transactionIcon: 'assets/svgIcons/taxi_expense.svg',
                  //   transactionType: 'Taxi Expense',
                  //   date: 'Feb 0, 20232',
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/menuMyWalletEReceipt');
                  //     print("object");
                  //   },
                  // ),
                  // TransactionCard(
                  //   img: SvgPicture.asset(
                  //     "assets/svgIcons/topup_icon.svg",
                  //     width: 53,
                  //   ),
                  //   name: 'Top Up Wallet',
                  //   transactionIcon: 'assets/svgIcons/topedup.svg',
                  //   transactionType: 'Top Up',
                  //   date: 'Feb 0, 20232',
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/menuMyWalletEReceipt');
                  //   },
                  // ),
                  // TransactionCard(
                  //   img: CircleAvatar(
                  //     radius:
                  //         26, // Adjust this value to change the size of the circular profile picture
                  //     backgroundImage: AssetImage(
                  //         'assets/images/babe.jpg'), // Replace this with your image asset path
                  //   ),
                  //   name: 'Divas Elk',
                  //   transactionIcon: 'assets/svgIcons/taxi_expense.svg',
                  //   transactionType: 'Taxi Expense',
                  //   date: 'Feb 0, 20232',
                  //   onPressed: () {},
                  // ),
                  // TransactionCard(
                  //   img: SvgPicture.asset(
                  //     "assets/svgIcons/topup_icon.svg",
                  //     width: 53,
                  //   ),
                  //   name: 'Top Up Wallet',
                  //   transactionIcon: 'assets/svgIcons/topedup.svg',
                  //   transactionType: 'Top Up',
                  //   date: 'Feb 0, 20232',
                  //   onPressed: () {},
                  // ),
                  // TransactionCard(
                  //   img: SvgPicture.asset(
                  //     "assets/svgIcons/topup_icon.svg",
                  //     width: 53,
                  //   ),
                  //   name: 'Top Up Wallet',
                  //   transactionIcon: 'assets/svgIcons/topedup.svg',
                  //   transactionType: 'Top Up',
                  //   date: 'Feb 0, 20232',
                  //   onPressed: () {},
                  // ),
                  // TransactionCard(
                  //   img: SvgPicture.asset(
                  //     "assets/svgIcons/topup_icon.svg",
                  //     width: 53,
                  //   ),
                  //   name: 'Top Up Wallet',
                  //   transactionIcon: 'assets/svgIcons/topedup.svg',
                  //   transactionType: 'Top Up',
                  //   date: 'Feb 0, 20232',
                  //   onPressed: () {},
                  // )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text("Error While ${snapshot.error}"),
              ),
            );
          }

          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Loading..."),
            ],
          ));
        });
  }
}

class TransactionCardGenerator extends StatelessWidget {
  const TransactionCardGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    return StreamBuilder<List<WalletTransaction>>(
        stream: db.getTransactionHistory(auth.getCurrentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transactionList = snapshot.data;
            print(transactionList!);

            final transaction = transactionList
                .map(
                  (transactionTile) => TransactionCard(
                    walletTransaction: transactionTile,
                  ),
                )
                .toList();

            return ListView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: transaction,
            );

            //     // List<Widget>.generate(6, (index) {
            //     //   return TransactionCard(walletTransaction: walletTransaction);
            //     // });
            //     ListView.builder(
            //   itemCount: 6,
            //   itemBuilder: (context, index) {
            //     return TransactionCard(
            //       walletTransaction: walletTransaction[index],
            //     );
            //   },
            // );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text("Error While ${snapshot.error}"),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}

class WalletArg {
  final UserHive userEntity;
  WalletArg({required this.userEntity});
}
