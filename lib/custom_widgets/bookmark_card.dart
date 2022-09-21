import 'package:flutter/material.dart';
import 'package:news60/components/global.dart';
import 'package:news60/components/text_styles.dart';


class BookmarkCard extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  BookmarkCard({required this.icon, required this.title, required this.onTap, required});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: Global.height(context) * 0.14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              "assets/images/$icon.png",
              height: 70,
              width: 70,
              fit: BoxFit.contain,
            ),
            Text(
              title,
              style: AppTextStyle.topiccardTitle,
            ),
          ],
        ),
      ),
    );
  }
}
