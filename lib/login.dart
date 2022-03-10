import 'package:design_demo_app/db/dbOperations.dart';
import 'package:design_demo_app/registration.dart';
import 'package:design_demo_app/widgets/custom_button.dart';
import 'package:design_demo_app/main.dart';
import 'package:design_demo_app/my_theme.dart';
import 'package:design_demo_app/strings.dart';
import 'package:design_demo_app/validations.dart';
import 'package:design_demo_app/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_tab_page.dart';

//LoginPage

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  late SharedPreferences login;
  bool isLoggedIn = false;

  TextEditingController loginEmailTEC = TextEditingController();
  TextEditingController loginPasswordTEC = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  bool _isObscure = true;

  checkIfLoggedIn() async{
    login = await SharedPreferences.getInstance();
    isLoggedIn = (login.getBool('isLoggedIn')?? false);

    if(isLoggedIn)
      Navigator.pushNamed(context, 'mainTabPage');
  }

  @override
  void initState() {
    super.initState();

    checkIfLoggedIn();
  }

  void cleartextFields(){
    loginEmailTEC.clear();
    loginPasswordTEC.clear();
  }

  //callBack on pressing the login button to validate the login form
  loginCallBack() async{
    String loginEmail = loginEmailTEC.text;
    String loginPassword = loginPasswordTEC.text;
    MainTabPageState.selectedTab = 0;
    if (loginFormKey.currentState!.validate()) {
     bool valid = await DBOperations.checkUser(loginEmail, loginPassword);
      if(valid) {
        setState(() {
          login.setBool('isLoggedIn', true);
          login.setInt('id', DBOperations.id);
          Navigator.pushNamed(context, 'mainTabPage');
          cleartextFields();
        });
      }else{
        Dialogs.showSnackBar(context, "Invalid email id or password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0.h),
                child:
                MyTheme.backgroundImageTheme(context: context,img: "assets/images/mike2.jpeg",opacity: 0.2, h:1, w:0.3),
              ),
              Center(
              child: Form(
                key: loginFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Strings.signIn,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        MyTheme.texFormFieldTheme(
                          context: context,
                          controller: loginEmailTEC,
                          label: Strings.emailLabel,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                          validationFunction: emailValidation,),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        PasswordTextField(
                          context: context,
                          controller: loginPasswordTEC,
                          label: Strings.passwordLabel,
                          isObscure: _isObscure,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          validationFunction: passwordValidation,),
                        SizedBox(
                          height: MyTheme.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButtonWidget(Strings.login,loginCallBack),
                            Text(
                              Strings.forgotPsw,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MyTheme.h + 5.h,
                        ),
                        MyTheme.lastLine(context: context, routeName: 'register', str1: Strings.noAccount, str2: Strings.signUp, page: "Login"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
