import 'package:flutter/material.dart';
import 'package:flutter_app_st/routers/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute
    );
  }
}
