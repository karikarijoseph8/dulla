import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/entities/contact_us_entity.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomerCareCard(),
              ContactUsGenerator(),
              // ContactUsCard(
              //   name: 'Website',
              //   icons: SvgPicture.asset(
              //     "assets/svgIcons/website.svg",
              //     width: 20,
              //   ),
              //   onPressed: () {},
              // ),
              // ContactUsCard(
              //   name: 'WhatsApp',
              //   icons: SvgPicture.asset(
              //     "assets/svgIcons/whatsapp.svg",
              //     width: 20,
              //   ),
              //   onPressed: () {},
              // ),
              // ContactUsCard(
              //   name: 'Facebook',
              //   icons: Icon(
              //     Icons.facebook_outlined,
              //     color: AppColors.mainYellow,
              //   ),
              //   onPressed: () {},
              // ),
              // ContactUsCard(
              //   name: 'Instagram',
              //   icons: SvgPicture.asset(
              //     "assets/svgIcons/instagram-filled.svg",
              //   ),
              //   onPressed: () {},
              // ),
              // ContactUsCard(
              //   name: 'Twitter',
              //   icons: SvgPicture.asset(
              //     "assets/svgIcons/twitter-filled.svg",
              //   ),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactUsGenerator extends StatelessWidget {
  const ContactUsGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseFutures>(context, listen: false);
    return FutureBuilder<List<ContactUsEntity>>(
      future: db.fetchContactUs(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<ContactUsEntity> contactList = snapshot.data ?? [];

          return Column(
              children: List.generate(contactList.length, (index) {
            final contact = contactList[index];
            return ContactUsCard(
              contactUsEntity: contact,
            );
          }));
        }
      },
    );
  }
}

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({
    super.key,
    required this.contactUsEntity,
  });

  final ContactUsEntity contactUsEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(contactUsEntity.contactType);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.09),
                offset: Offset(0, 3),
                blurRadius: 8,
              )
            ]),
        padding: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 18),
        margin: EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Icon(Icons),
            if (contactUsEntity.contactType == "website") ...[
              SvgPicture.asset(
                "assets/svgIcons/website.svg",
                width: 20,
              ),
            ] else if (contactUsEntity.contactType == "whatsapp") ...[
              SvgPicture.asset(
                "assets/svgIcons/whatsapp.svg",
                width: 20,
              )
            ] else if (contactUsEntity.contactType == "facebook") ...[
              Icon(
                Icons.facebook_outlined,
                color: AppColors.mainYellow,
              )
            ] else if (contactUsEntity.contactType == "instagram") ...[
              SvgPicture.asset(
                "assets/svgIcons/instagram-filled.svg",
              )
            ] else if (contactUsEntity.contactType == "twitter") ...[
              SvgPicture.asset(
                "assets/svgIcons/twitter-filled.svg",
              )
            ],

            SizedBox(
              width: 20,
            ),
            Text(
              contactUsEntity.contactHandle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerCareCard extends StatelessWidget {
  const CustomerCareCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/menuHelpCenterCustomerCare');
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.09),
                offset: Offset(0, 3),
                blurRadius: 8,
              )
            ]),
        padding: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 18),
        margin: EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Icon(Icons),
            SvgPicture.asset(
              "assets/svgIcons/customer_care.svg",
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Customer Care",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
