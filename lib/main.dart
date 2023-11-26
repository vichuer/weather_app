import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/env/theme.dart';
import 'package:weather_app/src/providers/homeProvider.dart';
import 'package:weather_app/src/providers/save_location_provider.dart';
import 'package:weather_app/src/screens/home/home.dart';
import 'package:weather_app/src/services/navigation_service.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => SaveLocationProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'The Weather App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: const HomeScreen(),
    );
  }
}
