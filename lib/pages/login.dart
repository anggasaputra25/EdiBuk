import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/logo_small.png'), width: 35, height: 35,),
                SizedBox(width: 10,),
                Text('EdiBuk', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),)
              ],
            ),
            SizedBox(height: 12,),
            Text('Masuk Dengan Akun Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)
          ],
        )
      ),
    );
  }
}