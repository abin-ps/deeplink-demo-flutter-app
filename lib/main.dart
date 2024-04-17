import 'package:deeplink_demo_app/routes.dart';
import 'package:flutter/material.dart';

// import 'screens/demo_screen.dart';

void main() {
  runApp( MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: goRouter,
    // home: DemoScreen(),
  ));
}
