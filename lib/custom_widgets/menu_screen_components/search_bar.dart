import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:news60/screens/search_screen.dart';
import 'package:provider/provider.dart';

/// This is the search in the menu screen
class SearchBar extends StatelessWidget {
  final color1;
  final color2;
  SearchBar({required this.color1, required this.color2});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchProviders(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 5, left: 20.0, right: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.search,
              color: color2,
              size: 20.0,
            ),
            SizedBox(width: 16),
            Text("search for news", style: AppTextStyle.searchHintTextStyle),
          ],
        ),
      ),
    );
  }
}
