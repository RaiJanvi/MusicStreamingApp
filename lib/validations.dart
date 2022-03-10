
//Validation methods for login and registration form

//to validate email field
emailValidation(String? val, String? label ){
  if(val!.isEmpty)
    return "Please Enter $label";
  else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val))
    return "Enter valid email";
  else
    return null;
}

//to validate password field
passwordValidation(String? val, String? label){
  if(val!.isEmpty)
    return "Please Enter $label";
  else if(val.length<4 || val.length>8 )
    return "Password should be 4 to 8  characters long";
  else
    return null;
}

//to validate confirm password field
cnfPasswordValidation(String? val, String? label, String password ){
  if(val!.isEmpty)
    return "Please Enter $label";
  else if(val != password )
    return "Password and confirm password should be same";
  else
    return null;
}

//to validate that field is not empty
emptyValidation(String? val, String? label){
  if(val!.isEmpty)
    return "Please Enter $label";
  else
    return null;
}
