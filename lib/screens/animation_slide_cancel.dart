import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/constants/app_colors.dart';

class SlideActionAnimation extends StatefulWidget {
  @override
  _SlideActionAnimationState createState() => _SlideActionAnimationState();
}

class _SlideActionAnimationState extends State<SlideActionAnimation>
    with SingleTickerProviderStateMixin {
  bool _isSlideVisible = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1, 0), // Slide from left
      end: Offset(0, 0),
    ).animate(_animationController);
  }

  void _toggleSlideVisibility() {
    if (_isSlideVisible) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isSlideVisible = !_isSlideVisible;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 11, top: 10, bottom: 10, right: 20),
      decoration: BoxDecoration(
        color: Colors.yellow, // Replace with your desired color.
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _toggleSlideVisibility,
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:
                    AppColors.lightYellow, // Replace with your desired color.
                borderRadius: BorderRadius.circular(50),
              ),
              child: SvgPicture.asset(
                "assets/svgIcons/bottom_sheet_close.svg",
                width: 10,
              ),
            ),
          ),
          SizedBox(width: 14),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              child: Text(
                ">>Slide to Cancel",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Replace with your desired color.
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Remember to replace Colors.yellow and Colors.lightYellow with your desired colors.
// Also, ensure to import the required packages for SvgPicture.asset and any custom colors used in the code.
