import 'package:design_demo_app/login.dart';
import 'package:design_demo_app/main_tab_page.dart';
import 'package:design_demo_app/my_theme.dart';
import 'package:design_demo_app/pages/songs_page.dart';
import 'package:design_demo_app/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Strings.dart';

void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ScreenUtilInit(
          minTextAdapt: true,
          builder: () => MaterialApp(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: Strings.appTitle,
            initialRoute: 'register',
            routes: {
              'login': (context) => Login(),
              'register': (context) => Registration(),
              'mainTabPage': (context) => MainTabPage(),
              'songsPage': (context) => SongsPage(),
            },
            theme: MyTheme.mainTheme(),
          ),

    );
  }
}
