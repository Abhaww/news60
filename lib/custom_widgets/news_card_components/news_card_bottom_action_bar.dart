import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/themes.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:news60/utils/utils.dart';
import 'package:provider/provider.dart';
import '../iconize_button.dart';

class BottomActionBar extends StatelessWidget {
  final shareScreenshot, saveScreenshot, bookmark;
  final IconData iconData;
  final String newsType;
  BottomActionBar({
    required this.shareScreenshot,
    required this.saveScreenshot,
    required this.bookmark,
    required this.iconData,
    required this.newsType,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Configs(),
      child: Consumer<Configs>(
        builder: (context, configs, widget) => Container(
          color: configs.darkMode == true
              ? AppColor.darkThemeColor
              : AppColor.background,
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
              border: newsType == '3'
                  ? null
                  : Border(
                      top: BorderSide(
                        color: configs.darkMode == true
                            ? AppColor.background
                            : Colors.black,
                      ),
                    ),
            ),
            child: Center(
              child: Column(
                children: [
                  // ? SizedBox()
                  // : SizedBox(
                  //     width: double.infinity,
                  //     child: Divider(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconizeButton(
                        color: configs.darkMode == true
                            ? AppColor.background
                            : AppColor.primary,
                        iconData: Icons.share_outlined,
                        onPress: shareScreenshot,
                      ),
                      IconizeButton(
                        color: configs.darkMode == true
                            ? AppColor.background
                            : AppColor.primary,
                        iconData: Icons.download,
                        onPress: saveScreenshot,
                      ),
                      IconizeButton(
                        color: configs.darkMode == true
                            ? AppColor.background
                            : AppColor.primary,
                        iconData: iconData,
                        onPress: bookmark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
