import 'package:flutter/material.dart';
import 'package:orbit/components/menu/booking/booking_card.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/entities/booking_entity.dart';
import 'package:provider/provider.dart';

import '../../../service/providers/auth_service.dart';
import '../../../service/streams/stream_provider.dart';

class CancelledBookingPage extends StatefulWidget {
  const CancelledBookingPage({super.key});

  @override
  State<CancelledBookingPage> createState() => _CancelledBookingPageState();
}

class _CancelledBookingPageState extends State<CancelledBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            MyBookingGenerator(),
          ],
        ),
      ),
    );
  }
}

class MyBookingGenerator extends StatelessWidget {
  const MyBookingGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    return StreamBuilder<List<BookingEntity>>(
        stream: db.getMyBooking(auth.getCurrentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final myBookingList = snapshot.data;

            final cancelledBooking = myBookingList!
                .where(
                  (booking) => booking.tripStatus == "Cancelled",
                )
                .toList();
            return Column(
                children: List.generate(cancelledBooking.length, (index) {
              final booking = cancelledBooking[index];
              return BookingCard(
                myBooking: booking,
              );
            }));
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
