import 'package:design_demo_app/strings.dart';
import 'package:design_demo_app/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../my_theme.dart';

//Date picker

class DatePickerWidget extends StatefulWidget {
  String? date;
  DatePickerWidget([this.date]);
  @override
  State<StatefulWidget> createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget> {
  static TextEditingController dateTEC = TextEditingController();

  static String selectedDate="";

  //to initialize the controller
  @override
  void initState() {
    dateTEC.text= widget.date??"" ;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: dateTEC,
      autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: true,
        decoration: InputDecoration(
          labelText: Strings.dob,
          prefixIcon: Icon(Icons.calendar_today,color: Theme.of(context).iconTheme.color,
            size: Theme.of(context).iconTheme.size,),
        ),
      style: Theme.of(context).textTheme.headline6,
        onTap: () async{
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1922),
              lastDate: DateTime.now(),
          );

          if(pickedDate != null ){
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            setState(() {
              dateTEC.text = formattedDate;
              selectedDate=formattedDate;
            });
          }else{
            dateTEC.text=selectedDate;
          }
        },
      validator: (value)=>emptyValidation(value, Strings.dob),
    );
  }
}
