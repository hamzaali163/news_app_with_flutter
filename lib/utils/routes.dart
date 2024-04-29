import 'package:flutter/material.dart';
import 'package:news_app/utils/route_names.dart';
import 'package:news_app/view/error_screen.dart';
import 'package:news_app/view/home_screen.dart';
import 'package:news_app/view/news_categories.dart';
import 'package:news_app/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateroutes(RouteSettings route) {
    switch (route.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RouteNames.categoriesScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NewsCategories());

      case RouteNames.errorScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            backgroundColor: Colors.red,
            body: Column(
              children: [
                Center(
                  child: Text('error, no screen found'),
                ),
              ],
            ),
          );
        });
    }
  }
}
