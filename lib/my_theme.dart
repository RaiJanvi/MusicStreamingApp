import 'package:design_demo_app/registration.dart';
import 'package:design_demo_app/validations.dart';
import 'package:design_demo_app/widgets/checkbox_widget.dart';
import 'package:design_demo_app/widgets/radio_button_widget.dart';
import 'package:design_demo_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class MyTheme{
  static double h = 20.0.h;
  static double w = 10.0.w;
  static bool obscure=true;
  static late SharedPreferences registration;

  //Main Theme for the app
  static mainTheme()=>ThemeData(

    primarySwatch: Colors.blueGrey,

    //Different textStyles
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w900, color: Colors.blueGrey),
      headline2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,),
      headline4: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w900,color: Colors.white),
      headline3: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold,color: Colors.white),
      headline5: TextStyle(fontSize: 15.sp,color: Colors.white),
      headline6: TextStyle(fontSize: 15.sp, color: Colors.white),
      subtitle1: TextStyle(fontSize: 17.sp, color: Colors.grey.shade600),
      bodyText1: TextStyle(fontSize: 17.sp, color: Colors.white60,),
      bodyText2: TextStyle(fontSize: 11.sp, color: Colors.white60),
    ),

    //scaffold background
    scaffoldBackgroundColor: Colors.black,

    //AppBar Theme
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        size: 29.sp,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w900,
      ),
    ),

    // TabBar Theme
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(fontSize: 15.sp),
      unselectedLabelStyle: TextStyle(fontSize: 11.sp),
    ),

    //InputDecoration for TextFormField
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 13.sp, color: Colors.white60),
      errorStyle: TextStyle(fontSize: 10.sp,),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white60),
      ),
    ),

    //ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.blueGrey[400]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0.sp),
            ),
          )),
    ),

    //SnackBar Theme
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
          fontSize: 15.sp,
          color: Colors.red,
        )),

    //Icon Theme
    iconTheme: IconThemeData(
      size: 20.h,
      color: Colors.white60,
    ),

    //Card Theme
    cardTheme: CardTheme(
      elevation: 7.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0.sp),
      ),
    ),

    //CheckBox Theme
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colors.white60),
    ),

    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );

  //Theme for the container of radioButton and checkbox
  static containerTheme(BuildContext context, String title, String className)=>Container(
    padding: EdgeInsets.only(bottom: 4.0.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white60),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0.w, top: 5.0.h),
          child: Text(title, style: Theme.of(context).textTheme.bodyText1,),
        ),
        SizedBox(width: w,),
        if(className=="radio")
          RadioButton()
        else if(className=="checkbox")
          CheckBoxWidget()
      ],
    ),
  );

  //to set background image
  static backgroundImageTheme(
      {required BuildContext context,
      required String img,
        AlignmentGeometry alignmentGeometry=Alignment.topRight,
      double opacity=0.5,
      double h=0.6,
      double w=0.6}){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

     return Align(
        alignment: alignmentGeometry,
        child: Opacity(
          opacity: opacity,
          child: Image.asset(img,
            height: height * h,
            width: width *w,
            fit: BoxFit.cover,
          ),
        ));
  }

  /* to allow user to navigate between loin and registration page
  on registration page if user already has an account can directly go to login page
  from login page user can go to registration page if he/she don't have an account */
  static lastLine({required BuildContext context, required String routeName, required String str1, required String str2, String? page})=>
      Row(
    children: [
      Text(
        str1,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      InkWell(
        onTap: () async{
          registration = await SharedPreferences.getInstance();
          if(page=="Login")
            registration.setBool('isRegistered', false);
          else if(page=="Register")
            registration.setBool('isRegistered', true);
          Navigator.pushNamed(context, routeName);
        },
        child: Text(
          str2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  //Theme of textFormField
  static texFormFieldTheme({required BuildContext context, required TextEditingController controller,
        required String label,
        required TextInputType keyboardType,
        required IconData icon,
        required Function validationFunction})=>TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).iconTheme.color,
          size: Theme.of(context).iconTheme.size,),
      ),
      style: Theme.of(context).textTheme.headline6,
      validator: (value) =>
          validationFunction(value, label)
  );
  }

  //Theme for password TextFormField
  class PasswordTextField extends StatefulWidget {
    BuildContext context;
    TextEditingController controller;
    String label;
    bool isObscure;
    TextInputType keyboardType;
    IconData prefixIcon;
    Function validationFunction;
    String? passwordText;

    PasswordTextField({required this.context, required this.controller,
      required this.label,
      required this.isObscure,
      required this.keyboardType,
      required this.prefixIcon,
      required this.validationFunction, this.passwordText});

    @override
    _PasswordTextFieldState createState() => _PasswordTextFieldState();
  }

  class _PasswordTextFieldState extends State<PasswordTextField> {

  String passwordText = RegistrationState.passwordTEC.text;

    @override
    Widget build(BuildContext context) {

      BuildContext context = widget.context;
      TextEditingController controller =widget.controller;
      String label = widget.label;
      bool isObscure =widget.isObscure;
      TextInputType keyboardType = widget.keyboardType;
      IconData prefixIcon = widget.prefixIcon;
      Function validationFunction=widget.validationFunction;

      return TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.isObscure,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(prefixIcon, color: Theme.of(context).iconTheme.color, size: Theme.of(context).iconTheme.size,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  isObscure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                setState(() {
                  widget.isObscure = !widget.isObscure;
                });
              },
            ),
          ),
          style: Theme.of(context).textTheme.headline6,
          validator: (value){
            print(widget.passwordText);
            if(widget.label== Strings.passwordLabel)
              return validationFunction(value,widget.label);
            else if(widget.label==Strings.cnfPasswordLabel)
              return validationFunction(value,label,widget.passwordText);
          }
      );
    }
}


