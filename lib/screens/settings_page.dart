import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: ValueListenableBuilder(
          valueListenable: Hive.box(Configs.darkModeBox).listenable(),
          builder: (context, Box box, childs){
            bool darkMode = Hive.box(Configs.darkModeBox).get('darkMode', defaultValue: true);
            return Text(
              'settings',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Roboto',
                color: darkMode ? AppColor.background : AppColor.primary,
              ),
            );
          }
        ),
        ),
      body: Consumer<Configs>(
        builder: (context, configs, child) => ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Theme'),
              subtitle: Text(
                  'Dark Theme Message'),
              onTap: () {
                // Provider.of<Configs>(context, listen: false).toggleDarkMode();
              },
              trailing: Switch(
                  activeColor: AppColor.background,
                  value: configs.darkMode,
                  onChanged: (status) {
                    Provider.of<Configs>(context, listen: false).toggleDarkMode(status);
                    print(configs.darkMode);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}