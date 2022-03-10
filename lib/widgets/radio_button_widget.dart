import 'package:design_demo_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Radio Button

List<String> gender=["Male", "Female", "Other"];

class RadioButton extends StatefulWidget {
  static String? genderVal;

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String group="Female";

  //returns the list of radio buttons
  List<Widget> createGenderRadio(){
    List<Widget> widgets=[];

    for(String i in gender){
      widgets.add(
        Expanded(
          child: Theme(
            data: ThemeData(
              iconTheme: IconThemeData(
                size: Theme.of(context).iconTheme.size,
              ),
              unselectedWidgetColor: Theme.of(context).iconTheme.color,
            ),
            child: ListTileTheme(
              horizontalTitleGap: 0,
              contentPadding: EdgeInsets.all(5.0.w),
              child: RadioListTile(
                  title: Text(i,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  activeColor: Colors.blueGrey,
                  value: i,
                  groupValue: group,
                  onChanged: (val){
                    setState(() {
                      group= val.toString();
                    });
                  },
                  ),
            ),
          ),
        ),
      );
      RadioButton.genderVal = group; //contains value(gender) selected by user
    }
    return widgets;
}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: createGenderRadio(),
    );
  }
}
