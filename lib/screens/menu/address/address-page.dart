import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/menu/addresstile.dart';
import 'package:orbit/screens/menu/address/view-address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
          "Address",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2B3138),
            fontSize: 17,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.add,
              size: 30,
              color: Color(0xFF747882),
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
            AddressTile(
              leftIconPath: 'assets/icons/Home-address.svg',
              title: 'Home',
              subTitle: 'Aduana Street, Abuakwa Markro',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewAddres(
                            address: 'Aduana Street, Abuakwa Markro',
                            extraNota: 'dsd',
                            placeName: 'Home',
                          )),
                );
              },
            ),
            AddressTile(
              leftIconPath: 'assets/icons/Work-address.svg',
              title: 'My Work',
              subTitle: 'Opoku Ware Hall, AAMUSTED Univer...',
              onPress: () {
                MaterialPageRoute(
                    builder: (context) => ViewAddres(
                          address: 'Opoku Ware Hall, AAMUSTED University',
                          extraNota: 'dsd',
                          placeName: 'My Work',
                        ));
              },
            ),
            AddressTile(
              leftIconPath: 'assets/icons/location2.svg',
              title: 'Market',
              subTitle: 'Palace street, Adum, Kumasi',
              onPress: () {},
            ),
            AddressTile(
              leftIconPath: 'assets/icons/locationMap.svg',
              title: 'Add Address',
              subTitle: 'Add new location or Address',
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
