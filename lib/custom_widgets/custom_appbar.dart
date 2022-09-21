import 'package:flutter/material.dart';
import 'package:news60/components/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/screens/settings_page.dart';

/// A customized appbar
class CustomAppBar extends StatelessWidget {
   final int index;
   final PageController pageController;
   final Color color;
   final IconButton iconButton;
   const CustomAppBar({this.index = 1, required this.pageController, required this.color, required this.iconButton});
   @override
   Widget build(BuildContext context) {
      final textStyle = TextStyle(
         fontSize: 20.0,
         fontFamily: 'Roboto',
         color: color,
      );
      return Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            index == 0
                ? Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  Expanded(
                     child: Align(
                        child: IconButton(
                           onPressed: () {
                              Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                    builder: (context) => SettingsScreen(),
                                 ),
                              );
                           },
                           icon: Icon(
                              Icons.settings,
                              size: 25.0,
                              color: color,
                           ),
                        ),
                        alignment: Alignment.centerLeft,
                     ),
                  ),
                  Text(
                     'Menu',
                     style: textStyle,
                     textAlign: TextAlign.center,
                  ),
                  Expanded(
                     child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                              Text(
                                 'News Feed',
                                 style: textStyle,
                              ),
                              SizedBox(
                                 width: 10.0,
                              ),
                              IconButton(
                                 onPressed: () {
                                    pageController.previousPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                 },
                                 icon: Icon(
                                    FontAwesomeIcons.chevronRight,
                                    color: color,
                                    size: 20.0,
                                 ),
                              ),
                           ],
                        ),
                     ),
                  )
               ],
            )
                : Row(
               children: [
                  Expanded(
                     child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                           children: [
                              IconButton(
                                 onPressed: () {
                                    pageController.previousPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                 },
                                 icon: Icon(
                                    FontAwesomeIcons.chevronLeft,
                                    color: color,
                                    size: 20.0,
                                 ),
                              ),
                              SizedBox(
                                 width: 10.0,
                              ),
                              Text(
                                 'Menu',
                                 style: textStyle,
                              ),
                           ],
                        ),
                     ),
                  ),
                  Text(
                     'News Feed',
                     style: textStyle,
                     textAlign: TextAlign.center,
                  ),
                  Expanded(
                     child: Align(
                        alignment: Alignment.centerRight,
                        child: iconButton,
                     ),
                  ),
               ],
            ),
            // SizedBox(
            //   height: 5.0
            // ),
            Container(
               width: 40.0,
               height: 3.0,
               decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100.0),
               ),
            ),
         ],
      );
   }
}
