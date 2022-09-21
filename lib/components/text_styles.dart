import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static final TextStyle searchHintTextStyle = TextStyle(
     // color: AppColor.primary,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      fontFamily: 'Roboto'
  );

  static final TextStyle appBarTitle = TextStyle(
    // color: AppColor.onBackground,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );
  static final TextStyle hashTagStyle = TextStyle(
    // color: AppColor.primary,
    fontFamily: 'Roboto',
    fontSize: 17.0,
  );
  static final TextStyle customAppBarTitleStyle = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Roboto',
    // color: Colors.black87,
  );
  static final TextStyle customAppBarNextTitleStyle = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Roboto',
    // color: Colors.black45,
  );
  static final TextStyle newsTitle = TextStyle(
    // color: Colors.black87,
    fontSize: 20,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
  );

  static final TextStyle newsSubtitle = TextStyle(
    // color: Colors.black54,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
  );

  static final TextStyle newsFooter = TextStyle(
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.italic,
  );
  static final TextStyle newsBottomTitle = TextStyle(
    color: AppColor.background,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle newsBottomSubtitle = TextStyle(
    color: AppColor.background,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle headline = TextStyle(
    // color: AppColor.onBackground,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );
  static final TextStyle topiccardTitle = TextStyle(
    // color: AppColor.onBackground,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
  );
  static final TextStyle searchbar = TextStyle(
    // color: AppColor.onBackground,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
  );
  static final TextStyle bottomActionbar = TextStyle(
    color: AppColor.iconGrey,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );
}
