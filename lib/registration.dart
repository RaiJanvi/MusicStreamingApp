import 'package:design_demo_app/widgets/checkbox_widget.dart';
import 'package:design_demo_app/widgets/custom_button.dart';
import 'package:design_demo_app/widgets/date_picker_widget.dart';
import 'package:design_demo_app/main.dart';
import 'package:design_demo_app/widgets/dialogs.dart';
import 'package:design_demo_app/widgets/radio_button_widget.dart';
import 'package:design_demo_app/strings.dart';
import 'package:design_demo_app/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:design_demo_app/db/database_helper.dart';
import 'package:design_demo_app/db/dbOperations.dart';
import 'my_theme.dart';

//Registration Page

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {
  late SharedPreferences registration;
  bool isRegistered=false;

  final registrationKey = GlobalKey<FormState>();
  bool _isObscure1 = true;
  bool _isObscure2 = true;

  TextEditingController userNameTEC = TextEditingController();
  TextEditingController lNameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  static TextEditingController passwordTEC = TextEditingController();
  TextEditingController cnfPasswordTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkIfRegistered();
  }


  //callBack on pressing register button to validate registration form
  registrationCallBack(){
    if (registrationKey.currentState!.validate()) {
      if (RadioButton.genderVal == null) {
        Dialogs.showSnackBar(context, "Please select gender");
      } else {
        String userName = userNameTEC.text;
        String password = passwordTEC.text;
        String email = emailTEC.text;
        String dob = DatePickerWidgetState.selectedDate;
        String gender = RadioButton.genderVal!;

        DBOperations.insertData(userName, email, password, dob, gender);

        setState(() {
          registration.setBool('isRegistered', true);

          Navigator.pushNamed(context, 'login');
        });
      }
    }
  }

  //callBack to toggle visibility and eye icon of password TextFormField
  passwordCallBack() {
    setState(() {
      MyTheme.obscure = !MyTheme.obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MyTheme.backgroundImageTheme(context: context,img: "assets/images/hp4.jpg",),
            Center(
              child: Form(
                key: registrationKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 15.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Strings.signUp,
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        MyTheme.texFormFieldTheme(
                            context: context,
                            controller: userNameTEC,
                            label: Strings.userName,
                            keyboardType: TextInputType.text,
                            icon: Icons.person,
                            validationFunction: emptyValidation),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        MyTheme.texFormFieldTheme(
                            context: context,
                            controller: emailTEC,
                            label: Strings.emailLabel,
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.email,
                            validationFunction: emailValidation),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        PasswordTextField(
                          context: context,
                          controller: passwordTEC,
                          label: Strings.passwordLabel,
                          isObscure: _isObscure1,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          validationFunction: passwordValidation,
                        ),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        PasswordTextField(
                          context: context,
                          controller: cnfPasswordTEC,
                          label: Strings.cnfPasswordLabel,
                          isObscure: _isObscure2,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          validationFunction: cnfPasswordValidation,
                          passwordText: passwordTEC.text,
                        ),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        DatePickerWidget(),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        MyTheme.containerTheme(context, "Gender", "radio"),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        MyTheme.containerTheme(context, "Language", "checkbox"),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        CustomButtonWidget(
                            Strings.register, registrationCallBack),
                    SizedBox(
                      height: MyTheme.h + 5.h,
                    ),
                    MyTheme.lastLine(context: context, routeName: 'login', str1: Strings.alreadyAcc, str2: Strings.signIn, page: "Register"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkIfRegistered() async{
    registration = await SharedPreferences.getInstance();
    isRegistered = (registration.getBool('isRegistered')??false);

    if(isRegistered)
      Navigator.pushNamed(context, 'login');
  }
}
