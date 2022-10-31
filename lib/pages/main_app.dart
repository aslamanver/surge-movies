import 'package:flutter/material.dart';
import 'package:surge_movies/pages/splash/splash_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surge Movies',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashPage(),
    );
  }
}
