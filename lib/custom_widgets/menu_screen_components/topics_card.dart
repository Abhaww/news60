import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/global.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:provider/provider.dart';

/// This the Categories Card Template
class CategoryCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final onTap;

  const CategoryCard({Key? key, this.icon, this.title, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: ValueListenableBuilder(
        valueListenable: Hive.box(Configs.darkModeBox).listenable(),
        builder: (context, Box box, childs) {
          bool darkMode = box.get('darkMode', defaultValue: true);
          return Container(
            margin: const EdgeInsets.all(8),
            height: Global.height(context) * 0.2,
            decoration: BoxDecoration(
              border: Border.all(
                color: darkMode == true ? AppColor.background  : AppColor.primary,
              ),
              // color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/$icon.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      title!,
                      style: AppTextStyle.topiccardTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}