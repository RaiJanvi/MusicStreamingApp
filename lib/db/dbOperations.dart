import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'dart:async';

/*methods to call and perform queries
  like: insert user data in table
      : check user in table
      : display current user's data
*/

class DBOperations{

  static List uId=[];
  static String uName="";
  static int id=0;
  static int userID=0;

  static late SharedPreferences login;

  //to execute insert query and insert data in database
   static insertData(String userName,String email,String password,String dob,String gender, ) async{
     int id = await DatabaseHelper.instance.insert(
         {
           DatabaseHelper.columnUName:userName,
           DatabaseHelper.columnEmail:email,
           DatabaseHelper.columnPassword:password,
           DatabaseHelper.columnDOB:dob,
           DatabaseHelper.columnGender:gender,
         });

     print("Inserted id $id");
  }

  //to check if user entered valid data in login form or not
  static Future<bool> checkUser(String email, String password) async{
    List<Map<String,dynamic>> user = await DatabaseHelper.instance.validateUser(email, password);

    if(user.length > 0) {
      uId = user.first.values.toList();
      id=uId.first;
      print("login id : $id");
      return true;
    } else
      return false;
  }

  //to fetch current user's data from database and convert it into list
  static Future<Map<String,dynamic>> displayData() async{
    login = await SharedPreferences.getInstance();
    userID = login.getInt('id')!;
     print("user: $userID");
     var detailsMap = await DatabaseHelper.instance.queryAll(userID);
     int count = detailsMap.length;

     Map<String,dynamic> detailsList={};

     for(int i=0; i<count; i++){
       detailsList=detailsMap[i];
     }
     return detailsList;
  }

  //to get current userName and display it in drawer header
  static getUserName() async{
    login = await SharedPreferences.getInstance();
    userID = login.getInt('id')!;
    print("user id: $userID");
    List<Map<String, dynamic>> userName = await DatabaseHelper.instance.userName(userID);
    String name= userName[0].values.toString();
    name= name.replaceAll('(', '').replaceAll(')', '');
    print(name);
    login.setString('userName', name);
  }

  //to update user details
  static Future<bool> updateDetails({required String name, required String email, required String dob, required String gender}) async{
    login = await SharedPreferences.getInstance();
    userID = login.getInt('id')!;

    int updateId = await DatabaseHelper.instance.update({
    DatabaseHelper.columnUName:name,
    DatabaseHelper.columnEmail: email,
    DatabaseHelper.columnDOB: dob,
    DatabaseHelper.columnGender: gender},
    userID);
    print("Update id: $updateId");
    if(updateId!=0)
      return true;
    else
      return false;
  }

  //to delete current user's account
  static Future<bool> deleteAccount() async{
    login = await SharedPreferences.getInstance();
    userID = login.getInt('id')!;

    int deleteId= await DatabaseHelper.instance.delete(userID);
    if(deleteId!=0)
      return true;
    else
      return false;
  }
}