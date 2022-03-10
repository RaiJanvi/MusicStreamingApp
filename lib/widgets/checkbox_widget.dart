import 'package:flutter/material.dart';

//class to create list of languages with boolean value displaying whether it's selected or not
class Languages {
  final String title;
  bool value;

  Languages(this.title, {this.value = false});
}

// Checkbox widget
class CheckBoxWidget extends StatefulWidget {
  //static List<Languages>? selectedLanguage;

  const CheckBoxWidget({Key? key}) : super(key: key);

  @override
  CheckBoxWidgetState createState() => CheckBoxWidgetState();
}

class CheckBoxWidgetState extends State<CheckBoxWidget> {
  static final language = [
    Languages("Hindi"),
    Languages("English"),
    Languages("Punjabi"),
    Languages("Tamil"),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              childAspectRatio: 4/1,
            ),
        shrinkWrap: true,
        itemCount: language.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  language[index].title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                value: language[index].value,
                onChanged: (value) {
                  setState(() {
                    language[index].value = value!;
                  });
                },
          );
        });
  }
}