import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/entities/address_entity.dart';
import 'package:orbit/screens/menu2/address/add_address_screen.dart';
import 'package:provider/provider.dart';

import '../../../components/customfont/customfonts.dart';
import '../../../routes.dart';
import '../../../service/providers/auth_service.dart';
import '../../../service/streams/stream_provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Address",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
          //margin: EdgeInsets.only(left: 20, right: 20),
          children: [
            Expanded(child: AddressCardGenerator()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: SubmitButton(
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   '/menuAddAddress',
                    // );

                    Navigator.of(context)
                        .push(SlidePageRoute(builder: (_) => AddNewAddress()));
                  },
                  buttonText: 'Add New Address',
                  btnColor: AppColors.mainYellow,
                ),
              ),
            ),
          ]),
    );
  }
}

class AddressCardGenerator extends StatelessWidget {
  const AddressCardGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    return StreamBuilder<List<AddressEntity>>(
        stream: db.getUserAddress(auth.getCurrentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final addressData = snapshot.data;

            return Column(
              children: List.generate(
                  addressData!.length,
                  (index) => AddressCard(
                        addressEntity: addressData[index],
                      )),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text("Error While ${snapshot.error}"),
              ),
            );
          }

          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });

    // Column(
    //   children: [
    //     AddressCard(),
    //     AddressCard(),
    //   ],
    // );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.addressEntity,
  });

  final AddressEntity addressEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Your onTap logic here
        print('InkWell tapped');
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 20, top: 20),
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyBorder, // Set the border color
              width: 1.0, // Set the border width
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/location_img.png',
                  width: 44,
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressEntity.addressName,
                      style: CustomFonts.urbanist(
                          color: AppColors.mainBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "73 Virginia, Ave. Attleboro, MA 02703",
                      style: CustomFonts.urbanist(
                          color: AppColors.greyMessages2, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                // Your onTap logic here
                print('InkWell tapped');
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/icons/edit_icon.png',
                  width: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
