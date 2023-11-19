import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/models/entities/user_entity.dart';
import '../../screens/menu2/menu.dart';

class Back2SelectRideButton extends StatelessWidget {
  const Back2SelectRideButton({
    super.key,
    required this.userData,
    required this.onPressed,
  });

  final UserEntity userData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.all(4),
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
            "assets/svgIcons/back2search_icon.svg",
            width: 40,
          ),
        ),
      ),
    );
  }
}
