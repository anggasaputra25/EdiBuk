import 'package:edibuk/pages/bar.dart';
import 'package:edibuk/pages/home.dart';
import 'package:edibuk/pages/search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Urbanist'),
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomePage(), 
        '/search': (context) => const SearchPage(), 
        '/bar': (context) => const Bar(), 
      },
    );
  }
}
