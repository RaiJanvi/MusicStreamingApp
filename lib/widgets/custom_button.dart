import 'package:design_demo_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//common class for buttons

class CustomButtonWidget extends StatelessWidget {
  final String btnText;
  final Function callBackFunction;

  CustomButtonWidget(this.btnText, this.callBackFunction);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white70,
      ),
      child: Padding(
        padding: EdgeInsets.all(13.h),
        child: Text(btnText,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      onPressed:() {
        FocusScope.of(context).unfocus();
        callBackFunction();
      }
    );
  }
}

