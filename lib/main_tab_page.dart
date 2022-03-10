import 'package:design_demo_app/pages/drawer_page.dart';
import 'package:design_demo_app/pages/home_page.dart';
import 'package:design_demo_app/pages/profile_page.dart';
import 'package:design_demo_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'my_theme.dart';

//Main Tab Page - containing home and profile tab

class MainTabPage extends StatefulWidget {
  MainTabPage({Key? key}) : super(key: key);
  @override
  MainTabPageState createState() => MainTabPageState();
}

class MainTabPageState extends State<MainTabPage> {
  static int selectedTab=0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 0.0.h),
          child: DefaultTabController(
            initialIndex: selectedTab,
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  bottomOpacity: 0,
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
              bottomNavigationBar: TabBar(
                  indicatorPadding: EdgeInsets.only(top: 2.h),
                  tabs: [
                    Tab(text: Strings.home,icon: Icon(Icons.home,)),
                    Tab(text: Strings.profile,icon: Icon(Icons.person,)),
                  ],
              ),
              drawer: MainDrawer(), //Drawer Class
              body: TabBarView(
                  children: [
                    HomePage(),                             //HomePage tab class
                    Expanded(child: ProfilePage(),),        //ProfilePage tab class
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
