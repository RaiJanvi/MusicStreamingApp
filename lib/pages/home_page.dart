import 'package:design_demo_app/pages/songs_page.dart';
import 'package:design_demo_app/strings.dart';
import 'package:design_demo_app/widgets/checkbox_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:design_demo_app/my_theme.dart';

//Home Page Tab - Displaying playlists of songs

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List category = CheckBoxWidgetState.language;

  @override
  Widget build(BuildContext context) {
    double gridHeight = MediaQuery.of(context).size.height;
    double gridWidth = MediaQuery.of(context).size.width;
    return Stack(
      children:[
        MyTheme.backgroundImageTheme(context: context,img: "assets/images/guitar2.jpeg", alignmentGeometry: Alignment.bottomRight,opacity: 0.4, ),
        SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h, left: 18.h, bottom: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Strings.choose,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    Strings.playByLang,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),

            //GridView displaying playlists
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (gridWidth * 0.45) / (gridHeight * 0.19),
                ),
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        String selected = category[index].title;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongsPage(selected: selected),
                            ));
                      },
                      child: Card(
                        color: Colors.indigo[50],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0.sp),
                          child: Container(
                            height: 12.h,
                            child: Center(
                                child: Text(
                              category[index].title,
                              style: Theme.of(context).textTheme.headline2,
                            )),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    ],
    );
  }
}
