import 'package:edibuk/pages/login.dart';
// import 'package:edibuk/pages/music_play.dart';
// import 'package:edibuk/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan Flutter telah diinisialisasi

  await Supabase.initialize(
    url: 'https://ukyncydcasqjcafxeyvr.supabase.co', // Ganti dengan URL Supabase kamu
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVreW5jeWRjYXNxamNhZnhleXZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI3ODI2NzcsImV4cCI6MjA1ODM1ODY3N30.uzRk7QSyNZS5Xyvq6gIm3-hWhLy83oH-GIb-m5Xjsp0', // Ganti dengan Anon Key dari Supabase
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Urbanist'),
      home: const LoginPage(),
    );
  }
}
