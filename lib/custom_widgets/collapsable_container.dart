import 'package:flutter/material.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:provider/provider.dart';

class CollapsableContainer extends StatelessWidget {
  final double? height;
  final bool topAppBarPadding;
  final Widget child;
  final bool isVisible;
  final Color color;
  const CollapsableContainer({
    required this.color,
    this.height,
    this.topAppBarPadding = false,
    required this.child,
    this.isVisible = true,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      height: isVisible ? height : 0,
      width: double.infinity,
      padding: topAppBarPadding
          ? EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)
          : EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(children: [Center(child: child)]),
    );
  }
}
