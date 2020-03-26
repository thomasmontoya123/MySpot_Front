// Route generator for the app 
// Handles the context for the navigation


// Dart imports
import 'package:flutter/material.dart';

// Pages import
import 'package:my_spot/src/pages/home_page.dart';
import 'package:my_spot/src/pages/login_page.dart';
import 'package:my_spot/src/pages/signup_page.dart';
import 'package:my_spot/src/pages/user_loged_page.dart';

Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
    '/'       : (context) => HomePage(),
    '/login'  : (context) => Login(),
    '/signup' : (context) => SignUp(),
    '/book'   : (context) => SignUp(),
    '/loged'  : (context) => UserLoged(),

  };

}