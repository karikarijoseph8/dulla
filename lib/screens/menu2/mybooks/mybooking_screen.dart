import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/menu2/mybooks/active_booking_page.dart';
import 'package:orbit/screens/menu2/mybooks/cancelled_booking_page.dart';
import 'package:orbit/screens/menu2/mybooks/completed_booking_page.dart';
import 'package:provider/provider.dart';

import '../../../models/entities/booking_entity.dart';
import '../../../service/providers/auth_service.dart';
import '../../../service/streams/stream_provider.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.mainBlack, // Change this to your desired color
          ),
          backgroundColor: Colors.white,
          title: Text(
            "My Bookings",
            style: CustomFonts.urbanist(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.mainBlack,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: MyBookingBody(),
      ),
    );
  }
}

class MyBookingBody extends StatelessWidget {
  const MyBookingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          labelColor: AppColors.mainYellow,
          unselectedLabelColor: AppColors.greyBalck,
          indicatorColor: AppColors.mainYellow,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: CustomFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          tabs: [
            Tab(
              text: "Active Now",
            ),
            Tab(
              text: "Completed",
            ),
            Tab(
              text: "Cancelled",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(children: [
            ActiveBookingPage(
                // myBookingList: activeBooking,
                ),
            CompletedBookingPage(),
            CancelledBookingPage(),
          ]),
        )
      ],
    );

    //  StreamBuilder<List<BookingEntity>>(
    //     stream: db.getMyBooking(auth.getCurrentUser()!.uid),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         final myBookingData = snapshot.data;

    //         final activeBooking = myBookingData!
    //             .where(
    //               (booking) => booking.tripStatus == "Active",
    //             )
    //             .toList();

    //         print("myBookingData");
    //         print(myBookingData);

    //         return Column(
    //           children: [
    //             TabBar(
    //               isScrollable: true,
    //               labelColor: AppColors.mainYellow,
    //               unselectedLabelColor: AppColors.greyBalck,
    //               indicatorColor: AppColors.mainYellow,
    //               indicatorSize: TabBarIndicatorSize.label,
    //               labelStyle: CustomFonts.urbanist(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w700,
    //               ),
    //               tabs: [
    //                 Tab(
    //                   text: "Active Now",
    //                 ),
    //                 Tab(
    //                   text: "Completed",
    //                 ),
    //                 Tab(
    //                   text: "Cancelled",
    //                 ),
    //               ],
    //             ),
    //             Expanded(
    //               child: TabBarView(children: [
    //                 ActiveBookingPage(
    //                  // myBookingList: activeBooking,
    //                 ),
    //                 CompletedBookingPage(),
    //                 CancelledBookingPage(),
    //               ]),
    //             )
    //           ],
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Container(
    //             child: Text("Error While ${snapshot.error}"),
    //           ),
    //         );
    //       }

    //       return Center(child: CircularProgressIndicator());
    //     });
  }
}
