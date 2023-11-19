import 'package:flutter/material.dart';

class SlideUpPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  SlideUpPageRoute({required this.builder})
      : super(settings: RouteSettings(name: '/slideuppage'));

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeOut;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
