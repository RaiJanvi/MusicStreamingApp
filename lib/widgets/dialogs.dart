import 'package:design_demo_app/db/dbOperations.dart';
import 'package:design_demo_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dialogs {
  static late SharedPreferences login;
  //SnackBar
  static showSnackBar(BuildContext context, String message,{Color color: Colors.red}) {
    var snackBar = SnackBar(
      content: Text(message,style: TextStyle(
        fontSize: 15.sp,
        color: color,
      ),),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Alert Dialog to confirm account deletion
  static Future<void> showAlertDialog(BuildContext context,) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: Border(
            top: BorderSide(color: Colors.red, width: 2.0.h),
          ),
        title: Column(
          children: [
            Center(
              child: Positioned(
                  top: 0,
                    child: Icon(Icons.delete, color: Colors.red,size: 35.h,),
                ),
            ),
            Text(Strings.deleteAccAlert,),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(Strings.alertContent ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text(Strings.cancelButton, style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  side: BorderSide(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(Strings.deleteButton,style: TextStyle(color: Colors.white),),
                onPressed: () {
                  DBOperations.deleteAccount().then((value) async{
                    if(value){
                      login = await SharedPreferences.getInstance();
                      login.setBool('isLoggedIn', false);
                      showSnackBar(context, "Account Deleted");
                      Navigator.pushNamed(context, 'login');
                    }
                  });
                },
              ),
            ],
          ),
        ],
          );
      },
    );
  }
}