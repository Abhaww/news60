// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';

Widget headLine(String title, Color color) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyle.headline,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: 36,
          height: 2.5,
          color: color,
        ),
      ],
    ),
  );
}
