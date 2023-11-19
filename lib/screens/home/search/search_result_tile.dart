import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truncate/truncate.dart';
//import '../../components/commons/app_icons.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
    required this.placeMainText,
    required this.placeSecondaryText,
    required this.inputText,
  }) : super(key: key);

  final String location;
  final String placeMainText;
  final String placeSecondaryText;
  final String inputText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.only(right: 10, bottom: 10),
        margin: EdgeInsets.only(bottom: 10, left: 9),
        // color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 26,
                  // color: Color(0xFFAAACAE),747682
                  color: Color(0xFF747682),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncate(placeMainText, 26, omission: "..."),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (placeSecondaryText == "")
                      ...[]
                    else ...[
                      Text(
                        truncate(placeSecondaryText, 30, omission: "..."),
                        style: GoogleFonts.poppins(color: Color(0xFF636773)),
                      )
                    ],
                  ],
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/icons/arrow-left-up.svg",
              width: 25,
              //color: Color(0xFF636773),
              color: Color(0xFF747682),
            )
          ],
        ),
      ),
    );
  }
}

TextSpan _highlightText(String text, String query) {
  List<TextSpan> spans = [];
  int start = 0;
  final maxLength = 26; // Set your desired maximum length here.

  // Truncate the text if it's longer than the maximum length.
  if (text.length > maxLength) {
    text = text.substring(0, maxLength) + '...';
  }

  // Loop through the text and find matches.
  while (start < text.length) {
    final startIndex = text.toLowerCase().indexOf(query.toLowerCase(), start);
    if (startIndex == -1) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(color: Colors.black),
      ));
      break; // Exit the loop when there are no more matches.
    } else {
      spans.add(TextSpan(
        text: text.substring(start, startIndex),
        style: TextStyle(color: Colors.black),
      ));
      spans.add(TextSpan(
        text: text.substring(startIndex, startIndex + query.length),
        style: TextStyle(color: Colors.green),
      ));
      start = startIndex + query.length;
    }
  }

  return TextSpan(children: spans);
}

TextSpan _highlightText2(String text, String query) {
  List<TextSpan> spans = [];
  int start = 0;

  if (text.length > 26) {
    text = text.substring(0, 26) + '...';
  }

  // Loop through the text and find matches.
  while (start < text.length) {
    final startIndex = text.toLowerCase().indexOf(query.toLowerCase(), start);
    if (startIndex == -1) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ));
      break;
    } else {
      spans.add(TextSpan(
        text: text.substring(start, startIndex),
        style: TextStyle(color: Colors.black),
      ));
      spans.add(TextSpan(
        text: text.substring(startIndex, startIndex + query.length),
        style: TextStyle(color: Colors.green),
      ));
      start = startIndex + query.length;
    }
  }

  return TextSpan(children: spans);
}
