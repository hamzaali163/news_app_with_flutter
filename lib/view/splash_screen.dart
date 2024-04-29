import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utils/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/splash_pic.jpg',
            fit: BoxFit.cover,
            height: screenheight * 0.5,
          ),
          SizedBox(
            height: screenheight * 0.04,
          ),
          Text(
            'Top Headlines',
            style: GoogleFonts.anton(
                letterSpacing: .6, color: Colors.grey.shade700),
          ),
          SizedBox(
            height: screenheight * 0.04,
          ),
          const SpinKitChasingDots(
            size: 40,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
