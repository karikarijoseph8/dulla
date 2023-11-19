import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({
    super.key,
    required this.title,
    required this.onPress,
  });

  final String title;
  final VoidCallback onPress;

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: widget.onPress,
        child: Container(
          margin: EdgeInsets.only(top: 9, bottom: 10, right: 10, left: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: CustomFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.mainBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: AppColors.mainYellow,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
