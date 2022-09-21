import 'package:hive/hive.dart';
import 'package:news60/configs/device_configs.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news60/bloc/device_id_bloc/device_id_bloc.dart';
import 'package:news60/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_udid/flutter_udid.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Utils utils = Utils();

  void getDeviceId() async {
    final deviceId = await FlutterUdid.udid;
    saveDeviceId(deviceId);
    final String deviceid = Hive.box('deviceInfo').get('deviceId');
    final deviceIdBloc = BlocProvider.of<DeviceIdBloc>(context);
    deviceIdBloc.add(
      SendDeviceIdEvent(deviceId: deviceid),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getDeviceId();

    super.initState();
  }
  Widget splashWidget = CircularProgressIndicator(
    color: AppColor.primary,
  );
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Utils(),
      child: Scaffold(
        body: BlocListener<DeviceIdBloc, DeviceIdState>(
          listener: (context, state) {
            if (state is SentDeviceIdState) {
              saveUserId(state.deviceIdResponse.userId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return Providers();
                }),
                  (Route<dynamic> route) => false,
              );
            } else if (state is SendingDeviceIdState) {
              print('sending');
            } else if(state is ErrorDeviceIdState) {
              setState(() {
                splashWidget = Text(
                  'Sorry an error has occurred! please restart the app',
                  style: AppTextStyle.newsFooter,
                );
              });
              print('error');
            }
          },
          child: splashScreen(),
        ),
      ),
    );
  }

  // Widget initialScreen() {
  //   return Container(
  //     height: double.infinity,
  //     width: double.infinity,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 200.0,
  //           width: 200.0,
  //           child: Image(
  //             image: AssetImage('assets/images/news360_logo.png'),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget splashScreen() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200.0,
            width: 200.0,
            child: Image(
              image: AssetImage('assets/images/news60.png'),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          splashWidget
        ],
      ),
    );
  }

  // Widget onError() {
  //   return Container(
  //     height: double.infinity,
  //     width: double.infinity,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 200.0,
  //           width: 200.0,
  //           child: Image(
  //             image: AssetImage('assets/images/news360_logo.png'),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20.0,
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }
}
