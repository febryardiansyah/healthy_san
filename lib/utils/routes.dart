import 'package:flutter/material.dart';
import 'package:healthy_san/ui/login/login_screen.dart';
import 'package:healthy_san/ui/register/register_screen.dart';

import '../ui/my_bottom_nav.dart';

MaterialPageRoute _pageRoute({required Widget body,required RouteSettings settings})=>MaterialPageRoute(builder: (_)=>body,settings: settings);

Route? generateRoute(RouteSettings settings){
  Route? _route;
  final _args = settings.arguments;
  switch(settings.name){
    case rLogin:
      _route = _pageRoute(body: LoginScreen(), settings: settings);
      break;
    case rRegister:
      _route = _pageRoute(body: RegisterScreen(), settings: settings);
      break;
    case rHome:
      _route = _pageRoute(body: MyBottomNav(), settings: settings);
      break;
  }
  return _route;
}

final NAV_KEY = GlobalKey<NavigatorState>();
const String rLogin = '/login';
const String rIndex = '/index';
const String rRegister = '/register';
const String rSplash = '/splash';
const String rHome = '/home';