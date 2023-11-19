import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:provider/provider.dart';

import '../../models/entities/privacy_policy_entity.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Privacy Policy",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(16),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: PrivacyPolicyGenerator(),
        ),
      ),
    );
  }
}

class PrivacyPolicyGenerator extends StatelessWidget {
  const PrivacyPolicyGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseFutures>(context, listen: false);
    return FutureBuilder<List<PrivacyPolicyEntity>>(
      future: db.fetchPrivacyPolicy(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<PrivacyPolicyEntity> policyList = snapshot.data ?? [];

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(policyList.length, (index) {
                final policy = policyList[index];
                return PrivacyPolicyCard(
                  privacyPolicyEntity: policy,
                );
              }));
        }
      },
    );

    // Column(
    //
    //   children: [
    //     PolicySection(
    //       header: '1. Data Collection',
    //       body:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
    //     ),
    //     PolicySection(
    //       header: '2. Data Usage',
    //       body:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
    //     ),
    //     PolicySection(
    //       header: '3. Data Sharing',
    //       body:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
    //     ),
    //     PolicySection(
    //       header: '4. Security',
    //       body:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
    //     ),
    //     PolicySection(
    //       header: '5. Cookies and Similar Technologies',
    //       body:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
    //     ),
    //     PolicySection(
    //       header: '6. Changes to This Privacy Policy',
    //       body:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt ante id sem pellentesque tristique.',
    //     ),
    //   ],
    // );
  }
}

class PrivacyPolicyCard extends StatelessWidget {
  final PrivacyPolicyEntity privacyPolicyEntity;

  PrivacyPolicyCard({required this.privacyPolicyEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${privacyPolicyEntity.policyCode}. ${privacyPolicyEntity.policyHeader}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 18),
          Text(
            privacyPolicyEntity.policyBody,
            style: CustomFonts.urbanist(
              fontSize: 14,
              color: AppColors.greyPrivacyPolicy,
            ),
          ),
        ],
      ),
    );
  }
}
