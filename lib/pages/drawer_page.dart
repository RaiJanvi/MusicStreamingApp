import 'package:design_demo_app/main_tab_page.dart';
import 'package:design_demo_app/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:design_demo_app/db/dbOperations.dart';

import '../my_theme.dart';
import '../strings.dart';

/*Drawer Class
  It creates drawer displaying img and name of current user
  also provides option to navigate to profile page and to logout
 */

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late SharedPreferences login;

  String userName="";

  final List<IconData> iconList =[Icons.person, Icons.settings, Icons.logout];
  final List iconTitles = ["Profile", "Settings", "Logout"];
  int userId=0;

  @override
  void initState(){
    super.initState();
    initial();
    DBOperations.getUserName();
  }

  //
  initial() async{
    login = await SharedPreferences.getInstance();

    setState(() {
      userName= login.getString('userName')!;
    });

  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width;
    initial();
    return Container(
      width: 250.w,
      child: Drawer(
        child: Column(
          children: [
            drawerHeader(context),
            Expanded(child: drawerBody(context),)
          ],
        ),
      ),
    );
  }

  //Header of the drawer
  Widget drawerHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.h),
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 85.h,
              width: 85.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("assets/images/avatar.png"),
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: MyTheme.h,
            ),
           Text(
             //login.getString('userName')!,
             //userId.toString(),
              userName,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ));
  }

  //Main Body of the drawer
  Widget drawerBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: iconList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap:(){
                      drawerNavigation(context, iconTitles[index]);
                    },
                    child: ListTile(
                      leading: Icon(iconList[index],size: Theme.of(context).iconTheme.size,),
                      title: Text(iconTitles[index], style: Theme.of(context).textTheme.subtitle1,),
                      minLeadingWidth: 45.h,
                      contentPadding: EdgeInsets.only(top: 10.0.w, left: 12.0.w),
                    ),
                  );
                }),
          ),
          Divider(
            thickness: 2.5,
          ),
          ListTile(
            leading: Icon(Icons.delete,size: Theme.of(context).iconTheme.size,),
            title: Text(Strings.deleteAcc,style: Theme.of(context).textTheme.subtitle1,),
            onTap: (){
              Dialogs.showAlertDialog(context);
            },
          )
        ],
      ),
    );
  }
  //To navigate from drawer to a specific page
  drawerNavigation(BuildContext context, String title){
    if(title == "Logout") {
      login.setBool('isLoggedIn', false);
      Navigator.pushNamed(context, 'login');
    } else if(title == "Profile") {
      MainTabPageState.selectedTab = 1;
      Navigator.pushNamed(context, 'mainTabPage');
    }
  }
}




