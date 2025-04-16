import 'package:edibuk/views/home.dart';
import 'package:edibuk/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final supabase = Supabase.instance.client;

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
      body: 
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logo_small.png'),
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'EdiBuk',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Buat Akun Anda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 54),

              // Input Email
              TextField(
                controller: emailController,
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
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Input Name
              TextField(
                controller: nameController,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "Masukkan Nama",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x2608060E)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x2608060E)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Input Password
              TextField(
                controller: passwordController,
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
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Confirm Password
              TextField(
                controller: confirmPasswordController,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Konfirmasi Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x2608060E)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x2608060E)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Tombol Register
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  final name = nameController.text.trim();
                  final password = passwordController.text;
                  final confirmPassword = confirmPasswordController.text;

                  if (email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Semua field harus diisi.")),
                    );
                    return;
                  }

                  if (password != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password tidak cocok.")),
                    );
                    return;
                  }

                  try {
                    final response = await supabase.auth.signUp(
                      email: email,
                      password: password,
                      data: {'name': name},
                    );

                    if (response.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Registrasi gagal.")),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6467F6),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Register',
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
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
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          ),
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
                        const webClientId =
                            '39551948215-5voa7thok925m2a8e824jgv9l7etpgbq.apps.googleusercontent.com';

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
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ), // Ganti dengan halaman utama Anda
                          );
                        } catch (e) {
                          print('Error during sign-in: $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
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
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 54),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah Mempunyai Akun?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(width: 3),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("'Lupa kata sandi' di klik");
                    },
                    child: Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 1,
                    height: 14,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      print("'Butuh bantuan' di klik");
                    },
                    child: Text(
                      'Butuh Bantuan?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
