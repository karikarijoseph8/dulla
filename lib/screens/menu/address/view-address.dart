import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/menu/addresstile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ViewAddres extends StatefulWidget {
  const ViewAddres({
    super.key,
    required this.placeName,
    required this.address,
    required this.extraNota,
  });
  final String placeName;
  final String address;
  final String extraNota;

  @override
  State<ViewAddres> createState() => _ViewAddresState();
}

class _ViewAddresState extends State<ViewAddres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF747882),
        ),
        centerTitle: true,
        title: Text(
          widget.placeName,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2B3138),
            fontSize: 17,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                color: Color(0xFF2B3138),
              ),
            ),
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            ViewAddressTile(
              title: 'Name',
              TxtContent: widget.placeName,
              placeHolder: 'Place name',
            ),
            ViewAddressTile(
              title: 'Address',
              TxtContent: widget.address,
              placeHolder: 'Enter place address',
            ),
            ViewAddressTile(
              title: 'Extra Note',
              TxtContent: widget.extraNota,
              placeHolder: 'Note about place',
            ),
          ],
        ),
      ),
    );
  }
}

showSlideSheet() {
  SlidingUpPanel(
      maxHeight: 300,
      // minHeight: 280,
      minHeight: 90,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(18.0),
        topLeft: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .5,
      panelSnapping: true,
      backdropEnabled: true,
      boxShadow: [
        BoxShadow(
            spreadRadius: 6,
            blurRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.05))
      ],
      body: Container(),
      panelBuilder: (controller) => Container(
            child: Column(
              children: [
                Text("data"),
                Text("data"),
                Text("data"),
              ],
            ),
          ));
}

void _showBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
            child: Column(
              children: [
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
              ],
            ),
          ));
}

class ViewAddressTile extends StatefulWidget {
  const ViewAddressTile({
    super.key,
    required this.title,
    required this.TxtContent,
    required this.placeHolder,
  });

  final String title;
  final String TxtContent;
  final String placeHolder;

  @override
  State<ViewAddressTile> createState() => _ViewAddressTileState();
}

class _ViewAddressTileState extends State<ViewAddressTile> {
  final TextEditingController txtContentController = TextEditingController();
  @override
  void initState() {
    txtContentController.text = widget.TxtContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF3F3FA),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(left: 20),
            child: TextFormField(
              controller: txtContentController,
              decoration: InputDecoration(
                hintText: widget.placeHolder,
                hintStyle:
                    GoogleFonts.poppins(color: Color(0xFFAAACAE), fontSize: 16),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(fontSize: 16),
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }
}
