import 'package:flutter/material.dart';
import 'package:orbit/components/menu/booking/booking_card.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/entities/booking_entity.dart';
import 'package:provider/provider.dart';

import '../../../service/providers/auth_service.dart';
import '../../../service/streams/stream_provider.dart';

class CompletedBookingPage extends StatefulWidget {
  const CompletedBookingPage({super.key});

  @override
  State<CompletedBookingPage> createState() => _CompletedBookingPageState();
}

class _CompletedBookingPageState extends State<CompletedBookingPage> {
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

            final completedBooking = myBookingList!
                .where(
                  (booking) => booking.tripStatus == "Completed",
                )
                .toList();
            return Column(
                children: List.generate(completedBooking.length, (index) {
              final booking = completedBooking[index];
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
