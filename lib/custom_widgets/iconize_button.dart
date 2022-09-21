import 'package:flutter/material.dart';
import 'package:news60/components/colors.dart';

class IconizeButton extends StatelessWidget {
  final IconData iconData;
  final onPress;
  final Color color;
  IconizeButton({required this.iconData, required this.onPress, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: color,
        size: 30,
      ),
      onPressed: onPress,
    );
  }
}
