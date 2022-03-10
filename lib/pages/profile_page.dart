import 'package:design_demo_app/widgets/custom_button.dart';
import 'package:design_demo_app/widgets/date_picker_widget.dart';
import 'package:design_demo_app/widgets/dialogs.dart';
import 'package:design_demo_app/widgets/radio_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:design_demo_app/db/dbOperations.dart';
import '../my_theme.dart';
import '../strings.dart';
import '../validations.dart';

//Profile Page - Displays the current user's details

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController pNameTEC= TextEditingController();
  TextEditingController pEmailTEC= TextEditingController();
  TextEditingController pDobTEC= TextEditingController();
  TextEditingController pGenderTEC= TextEditingController();

  final profileKey = GlobalKey<FormState>();

  bool editable = false;
  bool readOnly = true;

  String? date, gender, name, email;

   List uDetails=['id','name','pass','email','dob','gender'];
   List uDetails2=['name','email','dob','gender'];

  //list of icons
  final List<IconData> iconList = [
    Icons.person,
    Icons.email,
    Icons.calendar_today,
    Icons.person_outline
  ];

  //list of Titles
  final List iconTitles = ["Name", "Email", "Date of Birth", "Gender"];

  Map<String,dynamic> data={};

  //to convert map data into list of user details and display it on profile page;
  displayUserList(){
      Future<Map<String,dynamic>> userData= DBOperations.displayData();
      userData.then((data){
        setState(() {
          this.data = data;
          uDetails= List.from(data.values);
          int length=uDetails.length;
          int j=0;
          for(int i=0; i<length; i++){
            if(i==0 || i==3)
              continue;
            else {
            uDetails2[j] = uDetails[i];
            j++;
          }
        }
          print("UList: $uDetails");
        });
      });
  }

  @override
  void initState() {
    displayUserList();
    pNameTEC.text=uDetails2[0];
    pEmailTEC.text=uDetails2[1];
    super.initState();
  }

  //Callback method to update the user profile
  updateCallBack(){
    if(profileKey.currentState!.validate()){
      name= pNameTEC.text;
      email=pEmailTEC.text;
      date= DatePickerWidgetState.selectedDate;
      gender= RadioButton.genderVal!;

      DBOperations.updateDetails(name: name!, email: email!, dob: date!, gender: gender!).then((value) {
        if(value){
          setState(() {
            editable=false;
          });
          Dialogs.showSnackBar(context, "Profile Updated", color: Colors.green);
          displayUserList();
        }else{
          Dialogs.showSnackBar(context, "Details not Updated");
        }
      });
    }else{
      Dialogs.showSnackBar(context, "Enter valid Details");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("UList2: $uDetails2");
    pNameTEC.text=uDetails2[0];
    pEmailTEC.text=uDetails2[1];
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              editable = !editable;
            });
          },
          child: Icon(editable ? Icons.person_outline: Icons.edit),
        ),
        body: Stack(
          children:[
            MyTheme.backgroundImageTheme(context: context,img: "assets/images/cs2.jpeg",opacity: 0.3,h: 0.5,),
            SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 10.0.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    height: MediaQuery.of(context).size.height,
                    child: Column(  //here parent
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundImage: AssetImage("assets/images/avatar.png"),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                        radius: 18.r,
                                        child: IconButton(
                                            icon: Icon(Icons.add_a_photo),
                                            splashColor: Colors.transparent,
                                            onPressed: (){},
                                        ),
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MyTheme.h,
                          ),
                          Text(
                            uDetails2[0].toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: MyTheme.h,
                          ),
                          Expanded(
                            child: Column( //here
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0.w),
                                  child: Text(
                                    Strings.accInfo,
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),

                                Expanded(
                                    child: (editable)?
                                     //Displays editable form
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.w),
                                      child: Form(
                                        key: profileKey,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.0.h),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                controller: pNameTEC, //uDetails2[0],
                                                style: Theme.of(context).textTheme.headline6,
                                                decoration: InputDecoration(
                                                  labelText: iconTitles[0],
                                                  prefixIcon: Icon(iconList[0],
                                                    size: Theme.of(context).iconTheme.size,
                                                    color: Theme.of(context).iconTheme.color),
                                                ),
                                                validator: (value) =>
                                                  emptyValidation(value, iconTitles[0]),
                                                onSaved: (value){
                                                  name=value!;
                                                },
                                              ),
                                              SizedBox(
                                                height: MyTheme.h,
                                              ),
                                              TextFormField(
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                controller: pEmailTEC,     // initialValue: uDetails2[1],
                                                style: Theme.of(context).textTheme.headline6,
                                                decoration: InputDecoration(
                                                  labelText: iconTitles[1],
                                                  prefixIcon: Icon(iconList[1],
                                                      size: Theme.of(context).iconTheme.size,
                                                      color: Theme.of(context).iconTheme.color),
                                                ),
                                                  validator: (value) =>
                                                      emailValidation(value, iconTitles[1]),
                                                onSaved: (value){
                                                  email=value!;
                                                },
                                              ),
                                              SizedBox(
                                                height: MyTheme.h,
                                              ),
                                              DatePickerWidget(uDetails2[2].toString()),
                                              SizedBox(
                                                height: MyTheme.h,
                                              ),
                                              MyTheme.containerTheme(context, "Gender", "radio"),
                                              SizedBox(
                                                height: MyTheme.h,
                                              ),
                                              ElevatedButton(onPressed: ()=> updateCallBack(), child: Text("Edit", style: Theme.of(context).textTheme.headline6)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )

                                    //Displays user details
                                    : ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: iconList.length,
                                        padding: EdgeInsets.only(left: 7.w, bottom: 20.w, right: 15.w, top: 10.h),
                                        itemBuilder: (BuildContext context, int index) {
                                          return ListTile(
                                            minLeadingWidth: 10.h,
                                            contentPadding: EdgeInsets.only(
                                              top: 10.0.w, left: 12.0.w,),
                                            leading: Icon(iconList[index],
                                              size: Theme.of(context).iconTheme.size,
                                              color: Theme.of(context).iconTheme.color,
                                            ),
                                            title: Text(
                                              iconTitles[index],
                                              style: Theme.of(context).textTheme.headline5,
                                            ),
                                            subtitle: Text(
                                              uDetails2[index].toString(),
                                              style: Theme.of(context).textTheme.bodyText2,
                                            ),
                                          );
                                        })
                                    ),
                              ],
                            ),
                          )
                        ],
                      ),
                  )
                ],
              ),
            ),
          ),
    ],
        ),
      ),
    );
  }
}
