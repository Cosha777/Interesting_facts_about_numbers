import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_facts_about_numbers/ui/main_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          labelLarge: TextStyle(color: Colors.white70),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromRGBO(86, 86, 86, 0.8),
          ),
        ),
        scaffoldBackgroundColor: Colors.blueGrey[800],
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProviderScope(child: MainScreen()),
      },
      title: 'Numbers',
    );
  }
}
