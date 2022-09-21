// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news60/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'bloc/feeds_bloc/news_feed_bloc.dart';
import 'bloc/category_list_bloc/category_list_bloc.dart';
import 'bloc/device_id_bloc/device_id_bloc.dart';
import 'bloc/tags_ bloc/tags_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news60/components/themes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'components/colors.dart';
import 'configs/local_model.dart';
import 'configs/local_news_engines.dart';
import 'configs/settings_config.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalNewsModelAdapter());
  await Hive.openBox('newsId');
  await Hive.openBox('deviceInfo');
  await Hive.openBox('bookmark');
  await Hive.openBox(Configs.darkModeBox);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp])
      .then((_) => runApp(
    ChangeNotifierProvider(
    create: (context) => Configs(),
      child: MyApp(),),),
  );  
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Configs>(
      builder: (context, configs, child) {
       return MaterialApp(
         builder: (context, widget) => ResponsiveWrapper.builder(
           BouncingScrollWrapper.builder(context, widget),
           maxWidth: 1200,
           minWidth: 450,
           defaultScale: true,
           defaultScaleLandscape: false,
           breakpoints: [
             ResponsiveBreakpoint.resize(450, name: MOBILE),
             ResponsiveBreakpoint.autoScale(800, name: TABLET),
             ResponsiveBreakpoint.autoScale(1000, name: TABLET),
             ResponsiveBreakpoint.resize(1200, name: DESKTOP),
             ResponsiveBreakpoint.autoScale(2460, name: "4K"),
           ],
           background: Container(color: AppColor.background,),
         ),
         themeMode: configs.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: kLightThemeData,
          darkTheme: kDarkThemeData,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (BuildContext context) => NewsFeedBloc(ApiCalls(),),),
              BlocProvider(create: (BuildContext context) => CategoryListBloc(ApiCalls(),),),
              BlocProvider(create: (BuildContext context) => DeviceIdBloc(ApiCalls(),),),
              BlocProvider(create: (BuildContext context) => TagListBloc(ApiCalls(),),),
            ],
            child: SplashPage(),
          ),
        );
      },
    );
  }
}

