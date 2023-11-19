import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          "Profile",
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
            ProfilePageTile(
              title: 'Full name',
              placeHolder: 'Enter full name',
              TxtContent: 'Joseph Karikari',
            ),
            ProfilePageTile(
              title: 'Phone',
              placeHolder: 'Enter your number',
              TxtContent: '+233 547 980 900',
            ),
            ProfilePageTile(
              title: 'Email',
              placeHolder: 'Enter your email',
              TxtContent: 'jokarikar@gmail.com',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePageTile extends StatefulWidget {
  const ProfilePageTile({
    super.key,
    required this.title,
    required this.TxtContent,
    required this.placeHolder,
  });

  final String title;
  final String TxtContent;
  final String placeHolder;

  @override
  State<ProfilePageTile> createState() => _ProfilePageTileState();
}

class _ProfilePageTileState extends State<ProfilePageTile> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = widget.TxtContent;
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
              controller: textEditingController,
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
