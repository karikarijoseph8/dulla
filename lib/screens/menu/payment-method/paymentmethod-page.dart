import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF747882),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Payment Method",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2B3138),
            fontSize: 17,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20, top: 20),
        //     child: Text(
        //       "Save",
        //       style: GoogleFonts.poppins(
        //         color: Color(0xFF2B3138),
        //       ),
        //     ),
        //   )
        // ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
