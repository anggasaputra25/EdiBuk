import 'package:edibuk/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final supabase = Supabase.instance.client;

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  String? _userId;

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/logo_small.png'), width: 35, height: 35),
                SizedBox(width: 10),
                Text(
                  'EdiBuk',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Masuk Dengan Akun Anda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 54),

            // Input Email
            TextField(
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: "Masukkan Email",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x2608060E)),
                  borderRadius: BorderRadius.circular(9),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x2608060E)),
                  borderRadius: BorderRadius.circular(9),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 26),

            // Input Password
            TextField(
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Masukkan Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x2608060E)),
                  borderRadius: BorderRadius.circular(9),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x2608060E)),
                  borderRadius: BorderRadius.circular(9),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 32),

            // Tombol Login
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6467F6),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: 54),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol Facebook (tetap)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Facebook clicked!");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shadowColor: Colors.transparent,
                      side: BorderSide(color: Color(0x2608060E), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                          width: 28,
                          height: 28,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Tombol Google Sign-In
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      /// TODO: update the Web client ID with your own.
                      ///
                      /// Web Client ID that you registered with Google Cloud.
                      const webClientId = '39551948215-5voa7thok925m2a8e824jgv9l7etpgbq.apps.googleusercontent.com';

                      /// TODO: update the iOS client ID with your own.
                      ///
                      /// iOS Client ID that you registered with Google Cloud.
                      // const iosClientId = 'my-ios.apps.googleusercontent.com';

                      // Google sign in on Android will work without providing the Android
                      // Client ID registered on Google Cloud.

                      final GoogleSignIn googleSignIn = GoogleSignIn(
                        //clientId: iosClientId,
                        serverClientId: webClientId,
                      );
                      final googleUser = await googleSignIn.signIn();
                      final googleAuth = await googleUser!.authentication;
                      final accessToken = googleAuth.accessToken;
                      final idToken = googleAuth.idToken;

                      if (accessToken == null) {
                        throw 'No Access Token found.';
                      }
                      if (idToken == null) {
                        throw 'No ID Token found.';
                      }

                      // await supabase.auth.signInWithIdToken(
                      //     provider: OAuthProvider.google,
                      //     idToken: idToken,
                      //     accessToken: accessToken,
                      //   );

                      // print('UserID: $_userId');
                      try {
                        await supabase.auth.signInWithIdToken(
                          provider: OAuthProvider.google,
                          idToken: idToken,
                          accessToken: accessToken,
                        );

                        print(_userId);
                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(builder: (context) => HomePage()), // Ganti dengan halaman utama Anda
                        );
                      } catch (e) {
                        print('Error during sign-in: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shadowColor: Colors.transparent,
                      side: BorderSide(color: Color(0x2608060E), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png',
                          width: 28,
                          height: 28,
                        ),
                        Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}