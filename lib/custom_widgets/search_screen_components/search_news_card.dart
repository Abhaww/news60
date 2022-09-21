import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/global.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchNewsCard extends StatelessWidget {
 // final String date;
 final String title;
 final String image;
 final onTap;
 SearchNewsCard({required this.image, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
  //  var article = articles[index];

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: Global.width(context) * 0.18,
              child: Row(
                children: <Widget>[
                  Container(
                    width: Global.width(context) * 0.18,
                    height: Global.width(context) * 0.18,
                    color: AppColor.surface,
                    child: Image(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          // color: AppColor.onBackground,
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Text(
                  //       date,
                  //       style: TextStyle(
                  //           color: Colors.grey,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w300),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Global.width(context) * 0.22,
              ),
              child: ValueListenableBuilder(
                  valueListenable: Hive.box(Configs.darkModeBox).listenable(),
                  builder: (context, Box box, childs){
                    bool darkMode = box.get('darkMode', defaultValue: true);
                    return Divider(
                      height: 1,
                      color: darkMode == true
                          ? AppColor.background
                          : AppColor.grey,
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
