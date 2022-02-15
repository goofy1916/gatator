import 'package:flutter/material.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';

class WideButton extends StatelessWidget {
  const WideButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kButtonColor,
      height: kToolbarHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
