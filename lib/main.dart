import 'package:flutter/material.dart';
import 'package:news_app/utils/route_names.dart';
import 'package:news_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: Routes.generateroutes,
    );
  }
}
