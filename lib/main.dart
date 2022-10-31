import 'package:flutter/material.dart';
import 'package:surge_movies/data/providers/movie_provider.dart';
import 'package:surge_movies/pages/main_app.dart';
import 'package:provider/provider.dart';

void main() {
  // This is used for SQLite Database
  WidgetsFlutterBinding.ensureInitialized();

// MultiProvider is implemented, planned to use multiple providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        Provider(create: (context) => const MainApp()),
      ],
      child: const MainApp(),
    ),
  );
}
