import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/entities/user_entity.dart';
import 'package:provider/provider.dart';

import '../../data/hive/hive_boxes.dart';
import '../../screens/menu2/menu.dart';
import '../../service/providers/auth_service.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService auth = context.read<AuthService>();
    final userHiveData =
        boxUserHive.get(auth.getCurrentUser()!.uid) as UserHive;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Menu(
                    userEntity: userHiveData,
                  )),
        );
      },
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.all(10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                )
              ]),
          child: SvgPicture.asset(
            "assets/svgIcons/menu.svg",
          ),
        ),
      ),
    );
  }
}
