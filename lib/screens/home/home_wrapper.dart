import 'package:flutter/material.dart';
import 'package:orbit/models/entities/user_entity.dart';
import 'package:orbit/screens/home/home_screen.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/service/streams/stream_provider.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    String? uid = auth.getCurrentUser()!.uid;

    final db = Provider.of<Database>(context, listen: false);

    print("Currnt User: $uid");

    return StreamBuilder<UserEntity>(
        stream: db.getUserData(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data;
            print("Data fetched ${userData!.full_name}");
            print("Data fetched ${userData.signUpComplete}");

            return userData.signUpComplete
                ? const HomeScreen()
                : Container(
                    child: Text("data"),
                  );
          } else if (snapshot.hasError) {
            if (snapshot.error.toString() ==
                'Null check operator used on a null value') {
              print("Error While ${snapshot.error}");
              // return AccountSetupPhoneAuth(
              //   inCompleteSignup: true,
              // );
            }

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
  }
}
