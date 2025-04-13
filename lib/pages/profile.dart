import 'package:edibuk/pages/models.dart';
import 'package:flutter/material.dart';
import 'package:edibuk/pages/home.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:edibuk/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 3;
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    UserProfile? profile = await getUserProfile();
    setState(() {
      _userProfile = profile;
    });
  }

  Future<UserProfile?> getUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return null;

    return UserProfile(
      id: user.id,
      username: user.userMetadata?['name'] ?? user.email ?? 'Pengguna',
      profileImage: user.userMetadata?['picture'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                    _userProfile?.profileImage ??
                        'https://via.placeholder.com/50',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userProfile?.username ?? 'Guest',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Developer',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(20, 6, 14, 0),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.more_vert, size: 20, color: Colors.black),
                    onPressed: () {
                      print("Menu diklik!");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Riwayat Mendengarkan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal, // Mengaktifkan scroll horizontal
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Container diklik!");
                    },
                    child: Container(
                      width: 170,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.only(
                        right: 10,
                      ), // Tambahkan margin untuk jarak antar item
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(20, 6, 14, 0),
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              'https://i.pinimg.com/736x/3e/43/81/3e4381b778491865ef08b89d48c9366a.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Container diklik!");
                    },
                    child: Container(
                      width: 170,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.only(
                        right: 10,
                      ), // Tambahkan margin untuk jarak antar item
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(20, 6, 14, 0),
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              'https://i.pinimg.com/736x/3e/43/81/3e4381b778491865ef08b89d48c9366a.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Container diklik!");
                    },
                    child: Container(
                      width: 170,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.only(
                        right: 10,
                      ), // Tambahkan margin untuk jarak antar item
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(20, 6, 14, 0),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.network(
                              'https://i.pinimg.com/736x/3e/43/81/3e4381b778491865ef08b89d48c9366a.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 54),
            GestureDetector(
              onTap: () {
                print('Edit Profil diklik');
              },
              child: Row(
                children: [
                  Icon(Icons.person_outline, size: 20, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Edit Profil',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                print('Notifikasi diklik');
              },
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 20,
                    color: Colors.black,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Notifikasi',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                print('Download diklik');
              },
              child: Row(
                children: [
                  Icon(Icons.download_outlined, size: 20, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Download',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                print('Bahasa diklik');
              },
              child: Row(
                children: [
                  Icon(Icons.language_outlined, size: 20, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Bahasa',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                print('Bantuan & Dukungan diklik');
              },
              child: Row(
                children: [
                  Icon(Icons.help_outline, size: 20, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Bantuan & Dukungan',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                print('Tentang Kami diklik');
              },
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Tentang Kami',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                print('Keluar diklik');
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Keluar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlaylistPage()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            }
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ''),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note_list),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ''),
        ],
        selectedItemColor: const Color(0xFF6467F6),
        unselectedItemColor: Colors.grey.shade300,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
      ),
    );
  }
}
