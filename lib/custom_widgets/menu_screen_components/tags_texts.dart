import 'package:flutter/material.dart';
import 'package:news60/components/text_styles.dart';

/// This is a customized widget for HashTags
class HashTags extends StatelessWidget {
  final String? text;
  final onTap;
  const HashTags({Key? key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text!,
        style: AppTextStyle.hashTagStyle,
      ),
    );
  }
}
