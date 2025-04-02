import 'package:edibuk/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final supabase = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
    try {
      // Inisialisasi GoogleSignIn
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Login dibatalkan');
        return;
      }

      // Ambil autentikasi Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        print('Gagal mendapatkan ID Token dari Google');
        return;
      }

      // Kirim ID Token ke Supabase untuk autentikasi
      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      if (response.session != null) {
        print('Login berhasil: ${response.session?.user.id}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        print('Login gagal: ${response.toString()}');
      }
    } catch (error) {
      print('Error saat login: $error');
    }
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
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x2608060E)),
                  borderRadius: BorderRadius.circular(10),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x2608060E)),
                  borderRadius: BorderRadius.circular(10),
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
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6467F6),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.circular(10),
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
                    onPressed: signInWithGoogle, // Panggil fungsi login Google
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shadowColor: Colors.transparent,
                      side: BorderSide(color: Color(0x2608060E), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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