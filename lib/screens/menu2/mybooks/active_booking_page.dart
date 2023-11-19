import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbit/components/menu/booking/booking_card.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:provider/provider.dart';
import '../../../models/entities/booking_entity.dart';
import '../../../service/streams/stream_provider.dart';

class ActiveBookingPage extends StatefulWidget {
  const ActiveBookingPage({
    super.key,
  });

  @override
  State<ActiveBookingPage> createState() => _ActiveBookingPageState();
}

class _ActiveBookingPageState extends State<ActiveBookingPage> {
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

            final activeBooking = myBookingList!
                .where(
                  (booking) => booking.tripStatus == "Active",
                )
                .toList();
            return Column(
                children: List.generate(activeBooking.length, (index) {
              final booking = myBookingList[index];
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
