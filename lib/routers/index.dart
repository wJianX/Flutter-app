import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_st/pages/LoginPage/index.dart';
import 'package:flutter_app_st/pages/StartUpPage/index.dart';
import 'package:flutter_app_st/pages/Tabs.dart';
import 'package:flutter_app_st/pages/UserAgreePage/index.dart';

final Map<String, Function> routes = {
  '/': (context,{arguments}) => StartUpPage(),
  'login': (context,{arguments}) => LoginPage(),
  'ua': (context,{arguments}) => UserAgreePage(),
  'tabs' : (context,{arguments}) => Tabs()
  // 'tab' : (context,{arguments}) => MyTab1(arguments: arguments),
};

// ignore: missing_return, top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context, arguments: settings.arguments)
    );
    return route;
  }
};