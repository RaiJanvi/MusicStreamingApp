import 'dart:convert';
//import 'dart:js';
import 'package:design_demo_app/main.dart';
import 'package:design_demo_app/my_theme.dart';
import 'package:design_demo_app/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:design_demo_app/pages/song_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;

//Page displaying songs list

class SongsPage extends StatelessWidget {
  String? selected;

  SongsPage({this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0.h),
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(Strings.appTitle,style: Theme.of(context).appBarTheme.titleTextStyle,),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: ReadSongData(),
              builder: (context, data){
                if(data.hasError)
                  return Center(child: Text("${data.error}"),);
                else if(data.hasData) {
                  var items = data.data as List<SongDataModel>;
                  var selectedList = items.where((item) =>item.language!.contains(selected!)).toList();
                  return songPageBody(selectedList);
                } else
                  return Center(child: CircularProgressIndicator(),);
              }),
        ),
      ),
    );
  }

  //to fetch data from json file and store it in list
  Future<List<SongDataModel>>ReadSongData() async{
     final songData = await services.rootBundle.loadString('assets/json/songsList.json');
     final songDataList =json.decode(songData) as List<dynamic>;

     return songDataList.map((e) => SongDataModel.fromJson(e)).toList();
  }

  //ListView displaying songs list
  songPageBody(items){
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(6.h),
            child: Card(
              elevation: 5.0,
              child: Container(
                padding: EdgeInsets.all(4.h),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0.sp),
                      child: Image.asset(items[index].img,
                        height: 60.h,
                        width: 60.h,
                        fit: BoxFit.cover,),
                    ),
                    SizedBox(width: MyTheme.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[index].title,style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold,color: Colors.black
                          )),
                         Text(items[index].artist,style: TextStyle(
                             fontSize: 14.sp,color: Colors.black
                         )),
                        ],
                      ),
                    ),
                    IconButton(onPressed: (){},
                        padding: EdgeInsets.only(right: 10.w),
                        icon: Icon(Icons.play_arrow, size: Theme.of(context).iconTheme.size, color: Colors.black,)),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
