import 'package:flutter/material.dart';
import 'package:my_spot/src/pages/home_page.dart';
import 'package:my_spot/src/pages/login_page.dart';
import 'package:my_spot/src/pages/signup_page.dart';

Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
    '/'       : (context) => HomePage(),
    '/login'  : (context) => Login(),
    '/signup' : (context) => SignUp(),
    '/book'   : (context) => SignUp(),

  };

}